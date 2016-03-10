rem Brazenly copied from tuf.hds.com and modified to run non-interactively

rem Environment variables, these must be changed
set PFMINTERVAL=1
set PFMCOUNT=1435
set unitname=array_unit
set aauserid=array_user

set STONAVM_ACT=on
set STONAVM_RSP_PASS=on
set STONAVM_HOME=C:\Program Files (x86)\Storage Navigator Modular 2 CLI

rem ****************************************************
rem * Create unique folder                             *
rem ****************************************************

copy master_passwd.txt passwd.txt

Set CURRDATE=%TEMP%\CURRDATE.TMP
Set CURRTIME=%TEMP%\CURRTIME.TMP

DATE /T > %CURRDATE%
TIME /T > %CURRTIME%

Set PARSEARG="eol=; tokens=1,2,3,4* delims=/, "
rem
rem USA - mm-dd-yyyy - edit as required
rem
rem For /F %PARSEARG% %%i in (%CURRDATE%) Do SET MMDDYYYY=%%j-%%k-%%l_
rem
rem ROW - yyyy-mm-dd - edit as required
rem
For /F %PARSEARG% %%i in (%CURRDATE%) Do SET MMDDYYYY=%%l-%%k-%%j_

Set PARSEARG="eol=; tokens=1,2,3* delims=:, "
For /F %PARSEARG% %%i in (%CURRTIME%) Do Set HHMM=%%i-%%j-%%k

Set FILE_NAME=%MMDDYYYY%%HHMM%
@echo on
mkdir %FILE_NAME%
@echo off

rem ****************************************************
rem * Process request                                  *
rem ****************************************************

"%STONAVM_HOME%\auaccountenv" -set -uid %aauserid% -passwdfile passwd.txt

"%STONAVM_HOME%\auperform" -unit %unitname% -auto %PFMINTERVAL% -pfmstatis -count %PFMCOUNT% -path %FILE_NAME%

"%STONAVM_HOME%\auaccountenv" -rm
