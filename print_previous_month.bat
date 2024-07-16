@echo off & setlocal enabledelayedexpansion
REM batch script to print month 
set exitfaster=0
REM reliably retrieve current date/time using wmic
REM works across systems
for /f "tokens=1 delims=." %%i in ('wmic os get localdatetime ^| findstr /r "[0-9]"') do set current_date=%%i
REM extract month from date, 4th to 6th character
set current_month=%current_date:~4,2%

REM ask user how long he wants to go back
if "%1" NEQ "" set exitfaster=1&set howmany=%1 & goto :print
set /p howmany=how many months you want to go back?

:print
REM reliably get previous months number
set /a previous_month=current_month-%howmany%
REM handle exceptional cases where result of above is going to be 0
if %previous_month%==0 set previous_month=12
if %previous_month% LSS 0 set /a previous_month=12+previous_month

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

if %exitfaster% == 0 pause >NUL


