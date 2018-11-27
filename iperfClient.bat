@ECHO off
@REM iperf-client
@REM Connects to the iperf-server host and begins data transfer.
@REM Updated 2008-02-13

IF NOT EXIST Lib\iperf.exe ECHO could NOT find iperf.exe. Unable to continue & exit 1
IF NOT EXIST Lib\grep.exe ECHO could NOT find grep.exe. A CSV log will not be generated.
IF NOT EXIST Lib\sed.exe ECHO could NOT find sed.exe. A CSV log will not be generated.

:SETUP
SET SERVER="iperf.hyperoptic.com"
SET PORT=5210
SET TCPWIN="128k"
SET FORMAT="m"
SET INTERVAL=10
SET TESTLEN=60
SET UDP=n
SET LOGFILE=C:\logfile
SET GREPCMD="Mbits/sec$"
SET SEDCMD="s/sec//g; s/MBytes//g; s#Mbits/##g; s/-[ ]/-/g; s/[ ]\+/,/g; s/$/\r/g"

@REM  SET /P LOGFILE=Enter in a logfile name (w/o extension): 
@REM IF EXIST "%LOGFILE%.log" GOTO OVERWRITELOG
@REM :CONTINUE
@REM  SET /P SERVER=Enter in the iPerf server's IP address: 
@REM SET /P PORT=Enter a port to run on (%PORT%): 
@REM  SET /P UDP=Run UDP test (y/N): 
@REM  SET /P TESTLEN=Enter test duration in minutes (%TESTLEN%): 
@REM  SET /P INTERVAL=Enter the output interval in seconds (%INTERVAL%): 

REM SET /A TESTLEN *= 60

ECHO Test started on %DATE% %TIME%
start Lib\tail.exe -F "%LOGFILE%.log"
IF %UDP% == n Lib\iperf.exe -c %SERVER% -p %PORT% -d -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN% >> "%LOGFILE%.log"
IF %UDP% == N Lib\iperf.exe -c %SERVER% -p %PORT% -d -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN% >> "%LOGFILE%.log"
IF %UDP% == y Lib\iperf.exe -c %SERVER% -p %PORT% -d -u -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN%  >> "%LOGFILE%.log"
IF %UDP% == Y Lib\iperf.exe -c %SERVER% -p %PORT% -d -u -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN%  >> "%LOGFILE%.log"

IF EXIST Lib\grep.exe IF EXIST Lib\sed.exe GOTO PARSELOG

:END
ECHO Done
PAUSE
EXIT 0

:PARSELOG
Lib\grep.exe %GREPCMD% "%LOGFILE%.log" >> "%LOGFILE%.tmp"
ECHO [ID],Interval (s),Transfer (MBytes),Bandwidth (Mbits/sec) > "%LOGFILE%.csv"
Lib\sed.exe %SEDCMD% "%LOGFILE%.tmp" >> "%LOGFILE%.CSV"
del "%LOGFILE%.tmp"
GOTO END

:OVERWRITELOG
SET ANS=y
@REM  ECHO ** "%LOGFILE%.log" already exists.  Would you like to overwrite this file?
@REM  SET /P ANS=   (y/N): 
IF "%ANS%"=="n" GOTO SETUP
IF "%ANS%"=="N" GOTO SETUP
IF "%ANS%"=="y" del "%LOGFILE%.log" & GOTO CONTINUE
IF "%ANS%"=="Y" del "%LOGFILE%.log" & GOTO CONTINUE
ECHO    "%ANS%" is not valid
GOTO END
