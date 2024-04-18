 @echo off
          setlocal enabledelayedexpansion
          
          REM Get current date and time in MM/DD/YYYY HH:MM:SS format
          for /f "tokens=2 delims==." %%a in ('wmic OS get localdatetime /value') do set "datetime=%%a"
          set "date=!datetime:~4,2!/!datetime:~6,2!/!datetime:~0,4!"
          set "time=!datetime:~8,2!:!datetime:~10,2!:!datetime:~12,2!"
          
          REM Add 1 minute to the current time
          for /f "tokens=1-3 delims=:" %%a in ("!time!") do (
              set /a "hour=10%%a %% 100"
              set /a "minute=10%%b %% 100"
              set /a "second=10%%c %% 100"
          )
          set /a "minute=minute+1"
          if !minute! geq 60 (
              set /a "hour=hour+1"
              set /a "minute=minute-60"
          )
          if !hour! lss 10 set "hour=0!hour!"
          if !minute! lss 10 set "minute=0!minute!"
          if !second! lss 10 set "second=0!second!"
          
          REM Create the scheduled task
          SCHTASKS /CREATE /tn MyApp_2 /tr "\"C:\Dev En\Achieve_API\ak.bat\"" /sc once /st !hour!:!minute!:!second! /sd !date! /F
