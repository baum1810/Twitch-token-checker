@echo off
echo. >valid.txt
set /a counter=0
for /F "tokens=*" %%A in (tokens.txt) do set /a counter=counter + 1 

title loaded tokens: %counter%


:a

for /F "tokens=*" %%A in (tokens.txt) do set token=%%A && call :test
:test
curl -o check.txt -s -H "Authorization: OAuth %token%" https://id.twitch.tv/oauth2/validate >NUL && goto b

:b
findstr "invalid access token" check.txt >NUL 2>&1

if not errorlevel 1 (echo token is invalid %token% && del check.txt) else (echo valid: %token%   && del check.txt && echo %token% >>valid.txt)






