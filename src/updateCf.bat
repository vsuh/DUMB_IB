
@echo off

Set root1c=C:\Program Files (x86)\1cv8
Set ver1c=8.3.18.1483

"%root1c%\%ver1c%\bin\1cv8.exe" config /IBConnectionString %1 /UpdateDBCfg /out %2 /DisableStartupMessages /DisableStartupDialogs

exit %ERRORLEVEL%