@echo off
setlocal EnableDelayedExpansion
echo Turn on CAPSLOCK and Run as adminstrator
pause
cls

:getVolume
wmic logicaldisk get volumename,name

:getPath
rem Get path WriteProt.exe
set filePath=%0
goto :loop

:main
rem Input character of volume
echo Enter a character of volume:
set /p vol=%vol%

rem set full path WriteProt.exe
set pathVol=%filePath%\WriteProt.exe -vol %vol%: 

rem Lock and unlock usb 
echo Enter Lock/Unlock (L/U):
set /p ulock=%ulock%
cls
if "%ulock%" == "L" (
    echo Lock %vol% !
    call %pathVol% -ro -unsafe
    explorer %vol%:
    goto :end
) else if "%ulock%" == "U" (
    echo Unlock %vol% !
    call %pathVol% -rw -unsafe
    explorer %vol%:
    goto :end
) else (
    cls
    echo Invalid input. Please enter L or U.
    pause
    exit
)

:loop
set lastChar=%filePath:~-1%
if "%lastChar%" == "\" (
    set filePath=!filePath:~0,-1!
    goto :main
) else (
    set filePath=!filePath:~0,-1!
)
goto :loop

:end
pause
endlocal



