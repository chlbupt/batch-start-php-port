@echo off
echo "Stoping php-cgi..."
taskkill /F /IM php-cgi.exe > nul
call:printDelims

set ports=%1
set ports=%ports:-= %
set ports=%ports:~1,-1%

::ɱ��ָ���Ķ˿�
for /f "tokens=5" %%p in ('netstat -ano ^| findstr "%ports%"') do (
	taskkill /F /PID %%p
)
call:printDelims

echo Go on next[y/n?]
set /p OP1=
if not "%OP1%"=="y" (
	echo "Exiting..."
	exit
)

::����ָ���Ķ˿�
for %%i in (%ports%) do (
	echo "php-cgi port:%%i is starting..."
	RunHiddenConsole.exe %PHP_HOME%\\php-cgi.exe -b 127.0.0.1:%%i -c %PHP_HOME%\\php.ini
	sleep 1
)

::�鿴���ö˿�
call:printDelims
netstat -ano | findstr "%ports%" | findstr /v 0$
call:printDelims

::�鿴ռ�ö˿ڳ���
for /f "tokens=5" %%p in ('netstat -ano ^| findstr "%ports%" ^| findstr /v 0$') do (
	if %%p neq 0 (
		tasklist | findstr %%p
	)
)

:printDelims
echo ======================================================================
GOTO:EOF