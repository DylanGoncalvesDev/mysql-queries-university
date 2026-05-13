# 📌 SQL Evaluator

Este repositorio es un **template** que los estudiantes pueden usar para evaluar consultas SQL automáticamente mediante GitHub Actions. Sigue los pasos a continuación para configurar tu repositorio y comenzar con la evaluación.

---

## 🚀 1. Configurar tu repositorio

1. **Usa este repositorio como plantilla**  
   - Ve a la página de este repositorio en GitHub.  
   - Haz clic en **"Use this template"** y crea tu propio repositorio.  
   - Elige un nombre para tu repositorio y créalo.

2. **Clona tu repositorio**  
   ```sh
   git clone https://github.com/TU-USUARIO/TU-REPO.git
   cd TU-REPO
   ```

---

## ✍️ 2. Edita el archivo de queries

- Modifica el archivo `queries/queries.sql` con las consultas SQL que desees evaluar.

---

## 📤 3. Sube tus cambios

   ```sh
   git add queries/queries.sql
   git commit -m "💾 Añadir consultas SQL"
   git push origin main
   ```

---

## 🛠️ 4. Revisión automática con GitHub Actions

Cada vez que hagas un *push*, se ejecutará una acción en **GitHub Actions** que evaluará tus consultas SQL.  
Para ver los resultados:

1. **Ve a la pestaña "Actions" en GitHub**.  
2. Abre el último *workflow run* para ver los detalles.  
3. Puedes descargar el reporte generado en **Artifacts** bajo el nombre `Reporte_SQL`.
4. Se va generer un archivo `RESULTADOS.md` en la raíz de tu repositorio, que contendrá el resultado de la evaluación.

---

## 🔍 5. Revisar el reporte

El archivo `RESULTADOS.md` contendrá la evaluación de tus consultas. Puedes descargarlo desde **GitHub Actions** o revisarlo directamente en la raíz del repositorio.

### 📥 Obtener el reporte actualizado
Si `RESULTADOS.md` no aparece en tu copia local, ejecuta:

```sh
git pull origin main
```

Si necesitas corregir errores, actualiza `queries/queries.sql`, sube los cambios y vuelve a revisar el reporte.

---

## ❓ Preguntas Frecuentes

### 📌 ¿Qué evalúa este repositorio?
Este sistema revisa consultas SQL para verificar si los resultados coinciden con las salidas esperadas y si están optimizadas en términos de rendimiento.

### 🛠 ¿Cómo puedo ejecutar las pruebas en local?

Puedes ejecutar las pruebas en tu máquina local con los siguientes pasos:

1. Asegúrate de tener Docker, Python 3 y `pip` instalados.
2. Levanta la base de datos con Docker Compose:

```sh
docker compose up -d
```

3. Activa tu entorno virtual de Python (si no lo tienes creado, haz primero `python3 -m venv venv`):

```sh
source venv/bin/activate
pip install -r requirements.txt
````

4. Ejecuta el script de evaluación:

```sh
python -m src.scripts.check_queries
```

Esto generará el archivo `RESULTADOS.md` con el análisis de tus consultas.


### 🏆 ¿Cómo saber si mis consultas son correctas?
Si el reporte `RESULTADOS.md` indica que todas las queries son correctas (`✅`), significa que tus consultas cumplen con los criterios esperados.

Si hay errores (`❌`), revisa el reporte y ajusta tu código SQL en `queries/queries.sql`.

---

### 🛠 ¿Cómo puedo crear un evaluador de nuevas queries ?

1. Asegúrate de tener Docker, Python 3 y `pip` instalados.
2. Añade tu nuevo schema y añade datos en el archivo init_db.sql 
3. Levanta la base de datos con Docker Compose:

```sh
docker compose up -d
```

4. Activa tu entorno virtual de Python (si no lo tienes creado, haz primero `python3 -m venv venv`):

```sh
source venv/bin/activate
pip install -r requirements.txt
````

5. Ejecuta el script para generar los archivos en la carpeta src/expected_results:

```sh
python -m src.scripts.generate_expected
```