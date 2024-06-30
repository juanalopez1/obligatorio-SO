# Cómo configurar el entorno para la ejecución de Gestioner
### Instalar python

Ve a [python.org](python.org)

Haz clic en el botón de descarga para la versión recomendada (generalmente la última versión estable). Descarga para Windows.

Verifica la instalación en cmd con `python --version`

### Dependencias

Asegúrese de tener una versión de python actualizada (el proyecto se desarrolló con python 3.12), y tener las librerias
disponibles en `requirements.txt` instaladas. 

Para instalar unicamente las librerias utilizadas en el proyecto puede ejecutar:

```
pip install psutil
```
```
pip install wmi
```

### Instalar Git para la descarga de este repositorio

El repositorio tiene el codigo fuente.

Ve a [git-scm.com](git-scm.com) y descarga el instalador de Git para Windows.
Una vez instalado, descargue el repositorio con:
```
git clone https://github.com/juanalopez1/obligatorio-SO
```

# Ejecución

El punto de inicio del programa es `main.py`. Para ejecutarlo desde la línea de
comandos, ejecute (en el mismo directorio que el archivo):

```
python main.py
```