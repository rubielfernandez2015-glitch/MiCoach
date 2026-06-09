# MiCoach

Coach diario adaptativo para recomposición corporal. App de un solo archivo
(`index.html`), sin build ni backend: corre 100% en el navegador y guarda los
datos en `localStorage`. Usa la API de Gemini; cada usuario introduce su propia
API key en pantalla (no se guarda en el repo ni se incluye en los backups).

## Desplegar

Es un sitio estático. Sirve `index.html` desde la raíz en cualquier host
estático (Vercel, GitHub Pages, Cloudflare Pages…).

## Datos

El estado vive en `localStorage` y es **por dominio**. Al cambiar de URL, usa
el botón Exportar/Importar (backup JSON) dentro de la app para migrar tus datos,
y vuelve a introducir tu API key en el sitio nuevo.
