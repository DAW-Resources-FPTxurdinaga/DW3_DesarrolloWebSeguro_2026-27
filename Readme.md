# Plantilla MkDocs bilingüe (ES/EU)

Este repositorio es una plantilla lista para usar para el desarrollo de tutoriales en dos idiomas: español (es) y euskera (eu). Facilita mantener una estructura paralela de contenidos y una navegación coherente por idioma usando MkDocs con el tema Material y el plugin i18n.

## Objetivos
- **Plantilla** base para crear tutoriales bilingües.
- **Estructura** clara de carpetas por idioma.
- **Navegación** definida por idioma desde mkdocs.yml.
- **Estilos** y pequeños ajustes visuales personalizables.

## Estructura del proyecto
- **docs/**
  - **es/** contenido en español
  - **eu/** contenido en euskera
- **mkdocs.yml** configuración del sitio, tema y navegación por idioma
- **overrides/** personalizaciones del tema (p. ej., plantillas)
- **site/** salida generada al construir (no editar a mano)

## Configuración y requisitos
- Python 3.9+
- MkDocs y extensiones necesarias:
  ```bash
  pip install mkdocs mkdocs-material mkdocs-static-i18n pymdown-extensions
  ``` 

## Uso en desarrollo
- **Arrancar servidor local**:
  ```bash
  mkdocs serve
  ```
  Se abrirá un servidor local con recarga en caliente. Podrás alternar el idioma desde el selector del tema.

## Generar la web estática
- **Compilar** la documentación a HTML:
  ```bash
  mkdocs build
  ```
  Los archivos se generan en la carpeta site/.

## Añadir contenido
1. Crea/edita archivos en docs/es/ y su correspondencia en docs/eu/.
2. Actualiza la navegación en mkdocs.yml dentro del bloque plugins -> i18n -> languages para cada idioma.
3. Usa extensiones Markdown disponibles (admonition, tasklist, toc, footnotes, tables, attr_list).

## Notas
- No se hace referencia a plataformas específicas. La plantilla es agnóstica y se centra en MkDocs.
- Personaliza colores, logotipo y opciones del tema desde mkdocs.yml.

## Créditos
Basado en MkDocs Material e mkdocs-static-i18n.
