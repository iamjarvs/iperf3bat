@ECHO off
@REM iperf-client
@REM Connects to the iperf-server host and begins data transfer.
@REM Credit matthewlinton - original repo - https://github.com/matthewlinton/Windows-Scripts/blob/master/iPerf/iperf-client.bat
@REM Updated 27-11-2018

:SETUP
SET SERVER="iperf.hyperoptic.com"
SET PORT=5210
SET TCPWIN="128k"
SET FORMAT="m"
SET INTERVAL=5
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

IF %UDP% == n C:\iperf-3\iperf3.exe -c %SERVER% -p %PORT% -d -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN%
IF %UDP% == N C:\iperf-3\iperf3.exe -c %SERVER% -p %PORT% -d -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN%
IF %UDP% == y C:\iperf-3\iperf3.exe -c %SERVER% -p %PORT% -d -u -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN%
IF %UDP% == Y C:\iperf-3\iperf3.exe -c %SERVER% -p %PORT% -d -u -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN%

:END
ECHO Done
PAUSE
@pause