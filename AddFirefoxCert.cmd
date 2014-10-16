@echo off
rem AddFirefoxCert v1.0
rem This script is designed to add a CA to a windows Firefox installation in a domain environment
rem Run this script during user login
rem Tested on XP/Win7

rem NOTE: You will need to edit \\SERVERNAME\Path\To\Firefox-certificate-and-certutil and NAME-OF-YOUR-ROOT-CA.crt
rem to suit your environment

rem ---- copy dir file, nss exe and cert from unc paths to C:\windows\temp
mkdir C:\windows\temp\fcert > nul
copy "\\SERVERNAME\Path\To\Firefox-certificate-and-certutil\*.*" C:\windows\temp\fcert > nul

rem ---- Build path for randomly named profile directory
echo "%appdata%\Mozilla\Firefox\Profiles" >> C:\windows\temp\fcert\dir1.cmd
call C:\windows\temp\fcert\dir1.cmd > C:\windows\temp\fcert\fulldir.txt
set /p rndpname=<C:\windows\temp\fcert\fulldir.txt
set fullcertpath=%appdata%\Mozilla\Firefox\Profiles\%rndpname%

rem ---- Run addcert command
C:
cd \windows\temp\fcert
certutil -A -i C:\windows\temp\fcert\NAME-OF-YOUR-ROOT-CA.crt -n pi.planetinnovation.com.au -t "TCu,Cu,Tu" -d "%fullcertpath%"
del /q C:\windows\temp\fcert\*.*
