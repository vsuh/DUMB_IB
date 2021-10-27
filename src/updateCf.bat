@echo off
::chcp 65001>nul 
cd %~dp0\..

Set root1c=C:\Program Files (x86)\1cv8
Set ver1c=8.3.18.1483
if !%3!==!! (
	echo ТРЕБУЕТСЯ 3 параметра - строка соединения, код разрешения и имя файла лога
	exit 5
)
Set log=%3
if exist %log% del %log%
Set cmd=config /UC%2 /IBConnectionString %1 /UpdateDBCfg -Server -Dynamic–  /DisableStartupMessages /DisableStartupDialogs /out %3

echo 1cv8.exe %cmd%
"%root1c%\%ver1c%\bin\1cv8.exe" %cmd%

Set RC=%ERRORLEVEL%
dir %log%
copy %log% tt
if exist %log% type %log%
exit %RC%
