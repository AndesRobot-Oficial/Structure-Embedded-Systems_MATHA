# Guardar y subir a GitHub

Los archivos están preparados localmente. No se hizo commit ni push durante la organización.

Desde la carpeta de este repositorio:

```bash
git status
git switch -c documentacion-martha
git add README.md .gitignore sim.sh robot.sh docker docs firmware ros2_ws
git diff --cached --stat
git diff --cached --check
git commit -m "Organiza hardware y documentación de MARTHA"
git push -u origin documentacion-martha
```

Si la rama ya existe, usar `git switch documentacion-martha`. Revisar los archivos preparados antes del commit. Tras el push se puede abrir un Pull Request para incorporar la rama.

Los videos se enlazan desde la publicación existente de `martha_nav`; los MP4 no se duplicaron en Git. El inventario conserva registros pendientes. El firmware es la revisión que funciona en el robot (c8faa84).
