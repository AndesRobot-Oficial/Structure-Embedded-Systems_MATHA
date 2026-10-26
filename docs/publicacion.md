# Subir los cambios a GitHub

Desde la carpeta del repositorio:

```bash
git status
git add -A
git diff --cached --stat
git diff --cached --check
git commit -m "Enfoca MARTHA en RoboCup e incorpora PCB y video"
git push -u origin HEAD
```

Revisar el listado antes de confirmar. `git add -A` también registra las eliminaciones y reorganizaciones.

El archivo `docs/evidencias/videos/martha_demostracion.mp4` está permitido expresamente en `.gitignore`: pesa unos 11 MB y se incluye junto con las fotos. El README enlaza el archivo local, por lo que el enlace funcionará al subir esta misma estructura. El resto de archivos MP4 sigue excluido para evitar incorporaciones accidentales.

La organización local no ejecuta commit ni push. La visualización del video depende del visor de GitHub; el enlace permite abrir o descargar el archivo.
