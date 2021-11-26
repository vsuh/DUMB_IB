@echo off
::chcp 65001>nul 
cd %~dp0\..

Set deleteAge=3

if !%1!==!! (
	echo ТРЕБУЕТСЯ ПАРАМЕТР 1 - ПОЛНОЕ ИМЯ ФАЙЛА
	exit 3
)
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
:: src filename with path slashes normalized
Set fn=%1
Set fn=%fn:/=\%
::--@echo [CP]: got source file name: "%fn%"
Set dest=%2\%~nx1
::--@echo [CP]: got target full name: "%dest%"
Set root=%~dp1
::--@echo [CP]: got src folder name: "%root%"


if exist %dest% (
	@echo [CP]: target file "%dest%" exists - delete it
	del %dest%
)

:: create empty file on target side
:: cd.>>%dest%
@echo [CP]: COPY /Z /Y /V %fn% %dest%
>nul copy /Z /Y /V %fn% %dest% 
Set /a err=ERRORLEVEL
:: query created file size
for %%I in (%dest%) do Set /a sz=%%~zI
::--@echo [CP]: size of copied %dest% file %sz%
:: set errorlevel if empty file 
if %sz% EQU 0 set err=9
:: delete old files
@echo [CP:] delete dt files older than %deleteAge% days from %root% folder 
Set cmd="cmd.exe /c @del /q @path & @echo delete old (%deleteAge%d.) file @path [@fdate]"
2>nul Forfiles -p %root% -m *.dt -d -%deleteAge% -c %cmd%

exit %err%
:: *************************** ::
