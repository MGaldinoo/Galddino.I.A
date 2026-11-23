@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Galddino.IA (rapido)
rem Versao para testar velocidade: quantizacao menor, sem visao/audio, contexto menor.
start "Modelo" llama-server -hf bartowski/google_gemma-4-E4B-it-GGUF:Q4_K_M --no-mmproj -ngl 99 -c 8192 -np 1 --jinja --port 8081
timeout /t 3 >nul
start "" "%~dp0public\index.html"
pause
