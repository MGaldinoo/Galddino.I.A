@echo off
chcp 65001 >nul
cd /d "%~dp0"
title LLM-BR

where llama-server >nul 2>&1 || (
  echo Instalando llama.cpp...
  winget install llama.cpp
  echo.
  echo Pronto. FECHE esta janela e de dois cliques no iniciar.bat de novo.
  pause & exit /b
)

echo Iniciando o modelo (na primeira vez baixa alguns GB)...
start "Modelo" llama-server -hf bartowski/google_gemma-4-E4B-it-GGUF:Q5_K_M -ngl 99 -c 16384 -np 1 --jinja --port 8081

timeout /t 3 >nul
start "" "%~dp0public\index.html"
echo.
echo A pagina de chat foi aberta no navegador.
echo Quando o canto superior direito dela mostrar "modelo local pronto", pode conversar.
echo Para encerrar, feche a janela "Modelo".
pause
