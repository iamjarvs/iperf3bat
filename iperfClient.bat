@ECHO off
@REM iperf-client
@REM Connects to the iperf-server host and begins data transfer.
@REM Updated 2008-02-13

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

IF %UDP% == n iperf.exe -c %SERVER% -p %PORT% -d -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN% >> "%LOGFILE%.log"
IF %UDP% == N iperf.exe -c %SERVER% -p %PORT% -d -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN% >> "%LOGFILE%.log"
IF %UDP% == y iperf.exe -c %SERVER% -p %PORT% -d -u -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN%  >> "%LOGFILE%.log"
IF %UDP% == Y iperf.exe -c %SERVER% -p %PORT% -d -u -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN%  >> "%LOGFILE%.log"

:END
ECHO Done
PAUSE
