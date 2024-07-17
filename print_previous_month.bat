@echo off & setlocal enabledelayedexpansion
REM batch script to print month 
set something=%1
if not defined something set howmany=-1 & goto next
if %1 GTR 20000 goto :eof
if %1 LSS -20000 goto :eof
REM ask user how long he wants to go back
set howmany=%1
:next
REM reliably retrieve current date/time using wmic
REM works across systems
for /f "tokens=1 delims=." %%i in ('wmic os get localdatetime ^| findstr /r "[0-9]"') do set current_date=%%i
REM extract month from date, 4th to 6th character
set current_month=%current_date:~4,2%



:print
REM reliably get previous months number
set /a mod=%howmany% %% 12
set /a previous_month=current_month+mod
if %previous_month%==0 set previous_month=12
if %previous_month% LSS 0 set /a previous_month=12+previous_month
if %previous_month% GTR 12 set /a  previous_month=previous_month %% 12
REM define months 
set month_name=january february march april may june july august september october november december

REM store months in an array by index starting with 1
set index=1
for %%a in (%month_name%) do (
set month_by_index[!index!]=%%a
set /a index+=1
)

::FINALLY print the previous month
echo !month_by_index[%previous_month%]!



