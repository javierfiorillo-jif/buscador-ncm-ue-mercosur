@echo off
chcp 65001 >nul
title Configuración del repositorio GitHub — Buscador NCM UE-Mercosur
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║   Buscador NCM · Acuerdo UE-Mercosur                       ║
echo ║   Script de configuración del repositorio en GitHub         ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM ── Verificar que Git esté instalado ──
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Git no está instalado o no está en el PATH.
    echo Descargalo desde: https://git-scm.com/downloads
    echo.
    pause
    exit /b 1
)
echo [OK] Git encontrado: 
git --version
echo.

REM ── Pedir datos del usuario ──
set /p GITHUB_USER="Tu nombre de usuario de GitHub: "
if "%GITHUB_USER%"=="" (
    echo [ERROR] El nombre de usuario no puede estar vacío.
    pause
    exit /b 1
)

set /p REPO_NAME="Nombre del repositorio (dejá vacío para usar 'buscador-ncm-ue-mercosur'): "
if "%REPO_NAME%"=="" set REPO_NAME=buscador-ncm-ue-mercosur

echo.
echo ── Configuración ──
echo    Usuario:      %GITHUB_USER%
echo    Repositorio:  %REPO_NAME%
echo    URL remota:   https://github.com/%GITHUB_USER%/%REPO_NAME%.git
echo.
set /p CONFIRM="¿Es correcto? (S/N): "
if /I not "%CONFIRM%"=="S" (
    echo Cancelado por el usuario.
    pause
    exit /b 0
)

echo.
echo [1/5] Inicializando repositorio local...
git init
if %ERRORLEVEL% neq 0 (
    echo [ERROR] No se pudo inicializar el repositorio.
    pause
    exit /b 1
)

echo.
echo [2/5] Agregando todos los archivos...
git add .
if %ERRORLEVEL% neq 0 (
    echo [ERROR] No se pudieron agregar los archivos.
    pause
    exit /b 1
)

echo.
echo [3/5] Creando commit inicial...
git commit -m "🚀 Primer despliegue del Buscador NCM UE-Mercosur"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] No se pudo crear el commit.
    pause
    exit /b 1
)

echo.
echo [4/5] Configurando rama principal...
git branch -M main

echo.
echo [5/5] Conectando con GitHub y subiendo archivos...
git remote add origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git 2>nul
git remote set-url origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git
git push -u origin main
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] No se pudo hacer push. Posibles causas:
    echo   - El repositorio no existe en GitHub. Crealo primero en: https://github.com/new
    echo   - No tenés permisos o no estás autenticado.
    echo   - Intentá: git push -u origin main  (manualmente)
    echo.
    pause
    exit /b 1
)

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║   ✅ ¡Listo! Repositorio subido exitosamente.               ║
echo ║                                                              ║
echo ║   Ahora andá a GitHub:                                      ║
echo ║   Settings → Pages → Source → GitHub Actions                ║
echo ║                                                              ║
echo ║   Tu sitio estará disponible en:                            ║
echo ║   https://%GITHUB_USER%.github.io/%REPO_NAME%/              ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
pause
