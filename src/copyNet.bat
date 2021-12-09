@echo off
goto top
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:top
::chcp 65001>nul 
cd %~dp0\..

Set deleteAge=3

if _%1_==__ (
	echo ТРЕБУЕТСЯ ПАРАМЕТР 1 - ПОЛНОЕ ИМЯ ФАЙЛА
	exit 3
)
if _%2_==__ (
	echo ТРЕБУЕТСЯ ПАРАМЕТР 2 - СЕТЕВОЙ КАТАЛОГ
	exit 3
)
md %2 >nul 2>&1
if _%3_==__ (
	echo ТРЕБУЕТСЯ ПАРАМЕТР 3 - ДОМЕННОЕ ИМЯ ПОЛЬЗОВАТЕЛЯ
	exit 3
)

if _%4_==__ (
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
Set src.path=%1
Set fn=%src.path:/=\%
Set src.fn=%~nx1
::--@echo [CP]: got source file name: "%src.path%"
Set trg.fullpath=%2\%~nx1
::--@echo [CP]: got target full name: " %trg.fullpath%"
Set src.root=%~dp1
::--@echo [CP]: got src folder name: "%src.root%"


if exist  %trg.fullpath% (
	@echo [CP]: target file " %trg.fullpath%" exists - delete it
	>nul del  %trg.fullpath%
)

:: create empty file on target side
:: cd.>> %trg.fullpath%
@echo [CP]: COPY /Z /Y /V %src.path%  %trg.fullpath%
>nul copy /Z /Y /V %src.path%  %trg.fullpath% 
Set err=%ERRORLEVEL%
:: query created file size
IF NOT EXIST %trg.fullpath% ( 
		cd.>EMPTYFILE.%src.fn%
	) ELSE (
		2>nul forfiles /p %2 %/m %src.fn% /c "cmd.exe /c if @fsize==0 cd.>EMPTYFILE.%src.fn%
	)

:: set errorlevel if empty or absent file just copied
if EXIST EMPTYFILE. %trg.fullpath% set err=9
:: delete old local DT-files
@echo [CP:] delete dt files older than %deleteAge% days from %src.root% folder 
Set cmd="cmd.exe /c @del /q @path & @echo delete old (%deleteAge%d.) file @path [@fdate]"
>nul Forfiles -p %src.root% -m *.dt -d -%deleteAge% -c %cmd% 2>&1

exit %err%
:: *************************** ::
