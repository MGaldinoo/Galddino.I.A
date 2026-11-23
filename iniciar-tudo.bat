@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Galddino.IA

where llama-server >nul 2>&1 || (winget install llama.cpp & echo. & echo Instalado. FECHE e abra o iniciar-tudo.bat de novo. & pause & exit /b)
where cloudflared >nul 2>&1 || (winget install Cloudflare.cloudflared & echo. & echo Instalado. FECHE e abra o iniciar-tudo.bat de novo. & pause & exit /b)

if exist senha.txt goto temsenha
set /p NOVA=Crie uma senha de acesso (sem espacos): 
>senha.txt echo %NOVA%
:temsenha
set /p SENHA=<senha.txt

echo Iniciando o modelo...
start "Galddino - Modelo" llama-server -hf bartowski/google_gemma-4-E4B-it-GGUF:Q5_K_M -ngl 99 -c 16384 -np 1 --jinja --port 8081 --api-key %SENHA%

echo Abrindo o tunel para a versao online...
del tunel.log 2>nul
start "Galddino - Tunel" /min cmd /c "cloudflared tunnel --url http://127.0.0.1:8081 > tunel.log 2>&1"

set N=0
:espera
set /a N+=1
if %N% GTR 30 goto semtunel
timeout /t 2 >nul
powershell -NoProfile -Command "$t=Get-Content tunel.log -Raw -ErrorAction SilentlyContinue; if($t -match 'https://[a-z0-9-]+\.trycloudflare\.com'){$Matches[0]|Set-Content endereco.txt;Set-Clipboard $Matches[0];exit 0}else{exit 1}"
if errorlevel 1 goto espera
set /p ENDERECO=<endereco.txt

echo.
echo ================  GALDDINO.IA NO AR  ================
echo Endereco do tunel (ja copiado): %ENDERECO%
echo Senha: %SENHA%
echo Na versao online, clique em "Conexao" e cole o endereco e a senha.
echo Aguarde o topo do chat mostrar "modelo local pronto".
echo =====================================================
start "" "%~dp0public\index.html#k=%SENHA%"
pause
exit /b

:semtunel
echo Nao consegui obter o endereco do tunel. O chat local continua funcionando.
start "" "%~dp0public\index.html#k=%SENHA%"
pause
