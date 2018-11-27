@ECHO off
@REM iperf-client
@REM Connects to the iperf-server host and begins data transfer.
@REM Credit matthewlinton - original repo - https://github.com/matthewlinton/Windows-Scripts/blob/master/iPerf/iperf-client.bat
@REM Updated 27-11-2018
@REM the path for the iperf3.exe needs to be 'C:\iperf-3\iperf3.exe' or change path in line 22

:SETUP
SET SERVER="iperf server address or DNS"
SET PORT=5210
SET TCPWIN="128k"
SET FORMAT="m"
SET INTERVAL=5
SET TESTLEN=60
SET UDP=n
SET LOGFILE=C:\logfile
SET GREPCMD="Mbits/sec$"
SET SEDCMD="s/sec//g; s/MBytes//g; s#Mbits/##g; s/-[ ]/-/g; s/[ ]\+/,/g; s/$/\r/g"

ECHO Test started on %DATE% %TIME%

IF %UDP% == n C:\iperf-3\iperf3.exe -c %SERVER% -p %PORT% -d -w %TCPWIN% -f %FORMAT% -i %INTERVAL% -t %TESTLEN%

:END
ECHO Done
PAUSE
@pause
