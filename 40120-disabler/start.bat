@echo off



title [Anti-Charon ~ Stops Charon from running attacks with there skid net]
color 0a
echo.
echo Loaded Firewall rules
echo press enter to start firewall process

pause >nul
cls
:1 

echo Starting 40120 Blocking
netsh advfirewall firewall add rule name="Closed port 40120" dir=in action=deny protocol=TCP localport=40120
netsh advfirewall firewall add rule name="Closed port 40120" dir=in action=deny protocol=UDP localport=40120

goto done

:done
echo done
cls
msg * Firewall rules have been loaded