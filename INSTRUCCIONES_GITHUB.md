# 🚀 Guía paso a paso: Desplegar el Buscador NCM en GitHub Pages

Esta guía te lleva desde cero hasta tener tu buscador publicado en internet con una URL pública tipo:

```
https://TU-USUARIO.github.io/buscador-ncm-ue-mercosur/
```

---

## 📋 Requisitos previos

| Requisito | Detalle |
|---|---|
| Cuenta de GitHub | Gratuita: [github.com/signup](https://github.com/signup) |
| Git instalado | Descargá desde [git-scm.com](https://git-scm.com/downloads) |
| Los archivos del proyecto | Los que descargaste de Copilot |

---

## Paso 1 — Crear el repositorio en GitHub

1. Andá a [github.com/new](https://github.com/new).
2. Completá:
   - **Repository name**: `buscador-ncm-ue-mercosur`
   - **Description**: `Buscador de posiciones arancelarias NCM · Acuerdo UE-Mercosur`
   - **Visibilidad**: `Public` (obligatorio para GitHub Pages en plan gratuito)
   - ❌ **NO** marques "Add a README file" (ya tenemos uno).
   - ❌ **NO** marques "Add .gitignore" ni "Choose a license".
3. Hacé clic en **Create repository**.
4. GitHub te mostrará una pantalla con instrucciones. **Dejala abierta**, la necesitamos en el paso 3.

---

## Paso 2 — Preparar los archivos en tu computadora

Creá una carpeta y colocá **todos** estos archivos dentro:

```
buscador-ncm-ue-mercosur/
├── .github/
│   └── workflows/
│       └── deploy.yml          ← Workflow de GitHub Actions
├── .nojekyll                   ← Evita el procesamiento Jekyll
├── index.html                  ← Redirección automática al buscador
├── buscador_ncm_ue_mercosur_v3.html  ← Página principal del buscador
├── ncm_desde_pagina_13.json    ← Base de datos NCM (8.057 posiciones)
├── README.md                   ← Documentación del proyecto
├── INSTRUCCIONES_GITHUB.md     ← Esta guía
└── setup_repo.bat              ← Script automático (Windows)
```

---

## Paso 3 — Subir los archivos al repositorio

### Opción A: Script automático (Windows)

1. Abrí la carpeta del proyecto en el Explorador de archivos.
2. Hacé doble clic en `setup_repo.bat`.
3. El script te va a pedir:
   - Tu **nombre de usuario** de GitHub
   - El **nombre del repositorio** (usá `buscador-ncm-ue-mercosur`)
4. El script ejecuta los comandos de Git automáticamente.

### Opción B: Comandos manuales (cualquier sistema operativo)

Abrí una terminal en la carpeta del proyecto y ejecutá:

```bash
git init
git add .
git commit -m "🚀 Primer despliegue del Buscador NCM UE-Mercosur"
git branch -M main
git remote add origin https://github.com/TU-USUARIO/buscador-ncm-ue-mercosur.git
git push -u origin main
```

> ⚠️ Reemplazá `TU-USUARIO` por tu nombre de usuario de GitHub.

### Opción C: Subir desde la web de GitHub

1. En la página del repositorio vacío, hacé clic en **"uploading an existing file"**.
2. Arrastrá **todos los archivos y carpetas** del proyecto.
3. Hacé clic en **Commit changes**.

> ⚠️ Con este método, la carpeta `.github/workflows/` puede no subirse bien. Recomiendo la Opción A o B.

---

## Paso 4 — Habilitar GitHub Pages con Actions

1. Andá a tu repositorio en GitHub.
2. Hacé clic en **Settings** (⚙️) en la barra superior.
3. En el menú lateral izquierdo, buscá la sección **Pages**.
4. En **Build and deployment → Source**, seleccioná **GitHub Actions**.
5. **No hace falta elegir un workflow**: GitHub detecta automáticamente el archivo `deploy.yml` que ya subiste.

> 💡 Si ya hiciste push, probablemente el workflow ya se ejecutó. Verificá en el paso 5.

---

## Paso 5 — Verificar el despliegue

1. Andá a la pestaña **Actions** de tu repositorio.
2. Deberías ver un workflow llamado **"Desplegar a GitHub Pages"** en ejecución (ícono naranja 🟠) o completado (ícono verde ✅).
3. Si está ✅, hacé clic en el workflow y buscá la URL del sitio publicado.
4. También podés ir a **Settings → Pages** y verás un banner que dice:

   > ✅ Your site is live at `https://TU-USUARIO.github.io/buscador-ncm-ue-mercosur/`

5. **Hacé clic en esa URL** para abrir tu buscador. 🎉

---

## Paso 6 — ¡Listo! Compartí tu buscador

Tu URL pública es:

```
https://TU-USUARIO.github.io/buscador-ncm-ue-mercosur/
```

Podés compartirla con cualquier persona. No necesitan instalar nada, se abre en el navegador.

---

## 🌐 (Opcional) Dominio personalizado

Si querés usar un dominio propio (ej.: `ncm.tuempresa.com`):

1. Andá a **Settings → Pages → Custom domain**.
2. Escribí tu dominio y hacé clic en **Save**.
3. Configurá un registro `CNAME` en tu proveedor de DNS apuntando a `TU-USUARIO.github.io`.
4. Esperá unos minutos a que propague.
5. Activá **Enforce HTTPS**.

---

## 🔄 Cómo actualizar el sitio

Cada vez que hagas un `git push` a la rama `main`, el workflow se ejecuta automáticamente y actualiza el sitio en ~30 segundos.

```bash
# Ejemplo: actualizar el JSON con nuevos datos
git add ncm_desde_pagina_13.json
git commit -m "Actualizar base NCM"
git push
```

---

## 🛠 Solución de problemas

| Problema | Solución |
|---|---|
| El workflow falla con error de permisos | Andá a **Settings → Actions → General → Workflow permissions** y seleccioná **Read and write permissions** |
| La página muestra 404 | Verificá que **Settings → Pages → Source** esté en **GitHub Actions** (no en "Deploy from a branch") |
| El JSON no carga en la página | Confirmá que `ncm_desde_pagina_13.json` esté en la raíz del repositorio, en la misma carpeta que el HTML |
| El workflow no aparece en Actions | Verificá que la carpeta `.github/workflows/deploy.yml` se subió correctamente. La ruta debe ser exacta |
| No se genera el XLSX | SheetJS se carga desde CDN. Necesitás conexión a internet al usar la página |

---

## 📁 Estructura final del repositorio

```
buscador-ncm-ue-mercosur/
├── .github/workflows/deploy.yml    ← Automatización del despliegue
├── .nojekyll                       ← Deshabilita Jekyll
├── index.html                      ← Redirect al buscador
├── buscador_ncm_ue_mercosur_v3.html ← Buscador principal
├── ncm_desde_pagina_13.json        ← 8.057 posiciones NCM
├── README.md                       ← Documentación
├── INSTRUCCIONES_GITHUB.md         ← Esta guía
└── setup_repo.bat                  ← Script de setup (Windows)
```

---

> Creado con Microsoft Copilot · Junio 2026
