
@echo off
chcp 65001>nul 

Set root1c=C:\Program Files (x86)\1cv8
Set ver1c=8.3.18.1483
if !%3!==!! (
	echo ТРЕБУЕТСЯ 3 параметра - строка соединения, код разрешения и имя файла лога
	exit 5
)
echo 1cv8.exe" config /IBConnectionString %1 /UC %2 /UpdateDBCfg -Server  /DisableStartupMessages /DisableStartupDialogs /out %3
"%root1c%\%ver1c%\bin\1cv8.exe" config /IBConnectionString %1 /UC %2 /UpdateDBCfg -Server  /DisableStartupMessages /DisableStartupDialogs /out %3

exit %ERRORLEVEL%