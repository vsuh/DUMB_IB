
@echo off
chcp 65001>nul 


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

echo xcopy /V /I /Y /Z %fn% %2
xcopy /V /I /Y /Z %fn% %2

exit %ERRORLEVEL%

