@echo off
::chcp 65001>nul 
cd %~dp0\..


if !%1!==!! (
	echo ТРЕБУЕТСЯ ПАРАМЕТР 1 - ПОЛНОЕ ИМЯ ФАЙЛА
	exit 3
)
Set fn=%1
Set fn=%fn:/=\%
if !%2!==!! (
	echo ТРЕБУЕТСЯ ПАРАМЕТР 2 - СЕТЕВОЙ КАТАЛОГ
	exit 3
)
md %2 >nul 2>&1
if !%3!==!! (
	echo ТРЕБУЕТСЯ ПАРАМЕТР 3 - ДОМЕННОЕ ИМЯ ПОЛЬЗОВАТЕЛЯ
	exit 3
)

if !%4!==!! (
	echo ТРЕБУЕТСЯ ПАРАМЕТР 4 - СЕТЕВОЙ ПАРОЛЬ
	exit 3
)

if not exist %2 net use %2
if not exist %2 net use %2 %4 /user:%3
if not exist %2 (
	echo НЕ УДАЛОСЬ ПОДКЛЮЧИТЬ ДИСК %2
        exit 5
)

Set dest=%2\%~nx1
Set root=%~dp1
Set nmpt=%~n1
Set nmpt=%nmpt:~10,%
if exist %dest% del %dest%

echo xcopy /Y /Z /L %fn% %dest%
cd.>>%dest%
::echo f|xcopy /V /I /Y /Z /F /R  %fn% %dest%
xcopy /Y /Z /L %fn% %dest%

exit %ERRORLEVEL%

:: удаление старых файлов выгрузок
FOR %%A in (%root%\*.dt) DO (
	FOR /F %%K IN ("%%~tA") DO (
		FOR /F "delims=. tokens=1-3" %%X in ("%%K") DO SET /a fd=%%Z+%%Y*12*40+%%X
		SET /a df=!td!-!fd!
		IF !df! GEQ %kep% del %%A
		)
	)



exit %ERRORLEVEL%

