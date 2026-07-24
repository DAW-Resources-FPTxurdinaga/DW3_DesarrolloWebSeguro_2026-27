# COPILOT_INSTRUCCIONES

## 1. Objetivo del documento

Este archivo define las reglas permanentes para que GitHub Copilot genere documentación técnica homogénea durante todo el proyecto.

Estas instrucciones deben aplicarse en todas las páginas nuevas y en todas las revisiones de contenido.

El índice del curso se organiza por conceptos de desarrollo web seguro. Las tecnologías utilizadas en el ciclo (PHP, JavaScript, Laravel, Vue, etc.) se presentan como implementaciones de dichos conceptos y podrán sustituirse o ampliarse en el futuro sin modificar la estructura del curso.

## Estado de las páginas

Cada página del proyecto debe ser publicable en cualquier momento.

No utilizar comentarios `<!-- TODO -->` como marcador de contenido pendiente.

Si una página todavía no está desarrollada, contendrá únicamente:

- Título.
- Introducción.
- Estructura de secciones.
- Enlaces relacionados.

El contenido se irá ampliando progresivamente, pero la documentación nunca tendrá aspecto de borrador interno.

---

# 2. Antes de generar cualquier contenido

Antes de generar una página, Copilot debe comprobar que:

* El contenido está alineado con `MANIFIESTO.md`.
* El contenido aporta valor real a un desarrollador web.
* Puede relacionarse con los retos ETHAZI siempre que sea posible.
* No introduce teoría innecesaria.
* No convierte el curso en un manual de pentesting.
* Prioriza el aprendizaje mediante ejemplos y práctica.

Si alguna de estas condiciones no se cumple, debe replantear la propuesta.

---

# 3. Alcance

Este documento es interno para la producción editorial.

No es documentación para el alumnado.

No debe utilizarse para explicar teoría del curso ni para describir el funcionamiento de GitHub Copilot.

---

# 4. Estilo de redacción

Utilizar un tono técnico, profesional y directo.

Escribir frases cortas y precisas.

Evitar:

* relleno
* repeticiones
* lenguaje promocional
* opiniones innecesarias

Priorizar siempre la claridad y la utilidad práctica.

Mantener la terminología constante durante todo el proyecto.

---

# 5. Longitud de las páginas

Como referencia:

* Página conceptual: 700–1200 palabras.
* Página introductoria: 400–800 palabras.
* Laboratorio: 900–1600 palabras.

Si una página supera aproximadamente las 1400 palabras (excepto laboratorios), proponer dividirla.

---

# 6. Markdown

Utilizar una jerarquía clara de títulos.

* Un único `H1`.
* Secciones `H2`.
* Subsecciones `H3` cuando sean necesarias.

Abrir cada sección con una breve explicación.

Utilizar listas para:

* procedimientos
* criterios
* comprobaciones
* recomendaciones

Evitar párrafos superiores a seis líneas.

---

# 7. Tablas

Utilizar tablas únicamente cuando mejoren la comprensión.

Ejemplos:

* comparativas
* decisiones
* métodos HTTP
* códigos de estado
* cabeceras HTTP
* cookies
* permisos
* vulnerabilidades frente a soluciones

No utilizar tablas para texto narrativo.

---

# 8. Admonitions

Utilizar únicamente cuando aporten valor.

Tipos recomendados:

* note
* tip
* warning
* danger

Evitar encadenar varias admonitions seguidas.

---

# 9. Bloques de código

Todo bloque debe indicar el lenguaje.

Siempre incluir una breve explicación antes del código.

Los ejemplos deben ser:

* pequeños
* ejecutables
* realistas
* centrados en una única idea

No generar código innecesariamente complejo.

---

# 10. Ejemplos de código

Siempre que sea posible utilizar el mismo entorno tecnológico del curso:

* PHP 8
* Apache
* MySQL/MariaDB
* JavaScript moderno
* Laravel 11
* Vue 3
* Docker
* AWS Academy

Evitar ejemplos que requieran tecnologías distintas a las utilizadas por el alumnado.

Cada ejemplo debe indicar:

* objetivo
* código
* resultado esperado

---

# 11. Diagramas Mermaid

Utilizar Mermaid cuando facilite la comprensión.

Preferir diagramas pequeños.

Incluir una breve introducción antes del diagrama.

No generar diagramas únicamente por motivos estéticos.

---

# 12. Uso de imágenes

No generar imágenes decorativas.

Utilizar imágenes únicamente cuando mejoren la comprensión.

Priorizar:

* diagramas de arquitectura
* capturas de Burp Suite
* capturas de DVWA
* capturas de DevTools
* capturas de AWS Academy
* esquemas propios

---

# 13. Laboratorios

Los laboratorios forman parte del aprendizaje.

Siempre que sea posible utilizar:

* DVWA
* Burp Suite
* Docker
* DevTools

Estructura recomendada:

* objetivo
* requisitos
* preparación
* desarrollo
* comprobación
* conclusión

El laboratorio debe finalizar mostrando cómo solucionar el problema.

No basta con demostrar una vulnerabilidad.

---

# 14. Checklists

Utilizar checklists para verificar tareas.

Cada elemento debe comenzar con un verbo de acción.

Mantener entre cinco y doce elementos.

Todos los elementos deben ser verificables.

---

# 15. Ejercicios

Cada ejercicio debe indicar:

* objetivo
* enunciado
* criterio de evaluación
* dificultad (cuando proceda)

Escalar la dificultad progresivamente.

Priorizar ejercicios similares a situaciones reales.

---

# 16. Buenas prácticas editoriales

Mantener:

* coherencia terminológica
* formato homogéneo
* nombres consistentes
* estilo uniforme

Eliminar duplicidades.

Revisar ortografía y sintaxis antes de finalizar cualquier página.

---

# 17. Integración con ETHAZI

Siempre que sea posible, indicar cómo aplicar el contenido al reto que está desarrollando el alumnado.

Evitar contenidos aislados que no puedan relacionarse con el proyecto del curso.

---

# 18. Traducción al euskera

Traducir por significado técnico.

No traducir literalmente.

Mantener:

* la misma estructura
* el mismo nivel de detalle
* la misma terminología técnica

Conservar los nombres propios y aquellos términos ampliamente aceptados en inglés cuando corresponda.

---

# 19. Enlaces internos

Crear enlaces únicamente cuando aporten contexto útil.

Utilizar textos descriptivos.

Evitar enlaces redundantes.

Comprobar periódicamente que no existan enlaces rotos.

---

# 20. En caso de duda

Si existen varias formas de presentar un contenido:

* elegir la más sencilla;
* elegir la más práctica;
* elegir la más cercana al trabajo real de un desarrollador.

Nunca aumentar la complejidad únicamente para hacer el contenido más completo.

---

# 21. Validación final

Antes de dar una página por terminada comprobar que:

* aporta valor a un desarrollador web;
* está alineada con `MANIFIESTO.md`;
* utiliza ejemplos funcionales;
* mantiene un estilo homogéneo;
* puede integrarse en los retos ETHAZI;
* es fácil de mantener y ampliar;
* puede entenderse sin conocimientos no explicados previamente.

Si alguna de estas comprobaciones falla, revisar el contenido antes de considerarlo finalizado.
