"""Pruebas del URDF de Martha (no necesitan Gazebo ni el grafo de ROS, solo xacro).

Correr dentro del contenedor:
    cd /ros2_ws/src/andesrobot_description && python3 -m pytest -q test
"""
import itertools
import xml.etree.ElementTree as ET
from pathlib import Path

import numpy as np
import pytest
import xacro

URDF_DIR = Path(__file__).resolve().parents[1] / 'urdf'
CONTROLLERS = Path(__file__).resolve().parents[1] / 'config' / 'martha_controllers.yaml'


def expand(**args):
    """El URDF final (texto) con los argumentos de xacro dados."""
    mappings = {'controllers_file': str(CONTROLLERS)}
    mappings.update({k: str(v).lower() for k, v in args.items()})
    return xacro.process_file(str(URDF_DIR / 'martha.urdf.xacro'), mappings=mappings).toxml()


@pytest.mark.parametrize('path', sorted(URDF_DIR.glob('*.xacro')), ids=lambda p: p.name)
def test_sin_dos_puntos_y_espacio(path):
    # gazebo_ros2_control lee el URDF como YAML: "dos puntos + espacio" lo rompe (drive:=mecanum).
    lineas = [i + 1 for i, linea in enumerate(path.read_text().splitlines()) if ': ' in linea]
    assert not lineas, f'{path.name} tiene ": " en las líneas {lineas}'


@pytest.mark.parametrize('drive,sim,tower',
                         itertools.product(['planar', 'mecanum'], [True, False], [True, False]))
def test_frames_del_contrato(drive, sim, tower):
    texto = expand(drive=drive, sim=sim, tower=tower)
    assert ': ' not in texto
    robot = ET.fromstring(texto)
    # Solo los hijos directos de <robot>: ros2_control también tiene elementos <joint>.
    links = {link.get('name') for link in robot.findall('link')}
    hijos = {joint.find('child').get('link') for joint in robot.findall('joint')}
    # base_footprint es la raíz (nadie la tiene como hija) y laser / imu_link existen.
    assert 'base_footprint' in links and 'base_footprint' not in hijos
    assert {'base_link', 'laser', 'imu_link'} <= links
    assert any(name.startswith('tower_post') for name in links) == tower


def test_topics_del_contrato_en_simulacion():
    texto = expand(drive='planar', sim=True)
    for remap in ('~/out:=/nav/scan', '~/out:=/base/imu', 'cmd_vel:=/cmd_vel',
                  'odom:=/base/odom'):
        assert remap in texto
    assert '<robot_base_frame>base_footprint</robot_base_frame>' in texto


def test_sin_plugins_fuera_de_simulacion():
    assert '<plugin' not in expand(drive='planar', sim=False)


def _transformada(origin):
    """Matriz 4x4 de un <origin xyz rpy> (identidad si no hay)."""
    m = np.eye(4)
    if origin is None:
        return m
    r, p, y = (float(v) for v in (origin.get('rpy') or '0 0 0').split())
    rx = np.array([[1, 0, 0], [0, np.cos(r), -np.sin(r)], [0, np.sin(r), np.cos(r)]])
    ry = np.array([[np.cos(p), 0, np.sin(p)], [0, 1, 0], [-np.sin(p), 0, np.cos(p)]])
    rz = np.array([[np.cos(y), -np.sin(y), 0], [np.sin(y), np.cos(y), 0], [0, 0, 1]])
    m[:3, :3] = rz @ ry @ rx
    m[:3, 3] = [float(v) for v in (origin.get('xyz') or '0 0 0').split()]
    return m


@pytest.mark.parametrize('drive', ['planar', 'mecanum'])
def test_masa_y_centro_de_masa_medidos(drive):
    # Martha real pesada el 2026-11-04 (11.87 kg con la torre); el centro de masa en x, y salió
    # de pesar bajo cada rueda. Si cambias una masa del modelo, reajusta base_link.
    robot = ET.fromstring(expand(drive=drive, tower=True))
    padres = {j.find('child').get('link'): (j.find('parent').get('link'),
                                            _transformada(j.find('origin')))
              for j in robot.findall('joint')}

    def pose(link):
        if link not in padres:
            return np.eye(4)
        padre, t = padres[link]
        return pose(padre) @ t

    masa, momento = 0.0, np.zeros(3)
    for link in robot.findall('link'):
        inercial = link.find('inertial')
        if inercial is None:
            continue
        m = float(inercial.find('mass').get('value'))
        masa += m
        momento += m * (pose(link.get('name')) @ _transformada(inercial.find('origin')))[:3, 3]
    x, y, _ = momento / masa
    assert masa == pytest.approx(11.87, abs=0.01)
    assert x == pytest.approx(-0.10, abs=0.005)
    assert y == pytest.approx(0.0, abs=0.005)
