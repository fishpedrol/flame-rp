:inicio
@echo off
cls
color 04
echo --------------- Flame Evolved ------------------
echo.
echo        Para ligar o Servidor Digite 1 
echo.
echo        Para limpar o Cache Digite 2
echo.
echo         Para sair do MENU Digite 0
echo.
echo.
echo ---------------------------------------------------





set /p Comando= Digite uma Opcao : 

if "%Comando%" equ "1" (goto:op1)
if "%Comando%" equ "2" (goto:op2)
if "%Comando%" equ "0" (goto:exit)

cls

:op1
echo Ligando o SERVIDOR aguarde...

start server\FXServer.exe +exec config.cfg +set onesync on +set onesync_population false +set sv_enforceGameBuild 2189 +set onesync_enableInfinity 1

goto:inicio
:exit

:op2
echo Limpando o CACHE da base aguarde...
rd /s /q "cache"
timeout 5
goto:inicio
:exit

exit