set name=MyStrategy

if not exist %name%.pas (
    echo Unable to find %name%.pas > compilation.log
    exit 1
)

del /F /Q %name%.exe *.ppu *.o *.dcu *.pcu

set COMPILER_PATH="

if "%FREEPASCAL_HOME%" neq "" (
    if exist "%FREEPASCAL_HOME%\bin\i386-win32\fpc.exe" (
        set COMPILER_PATH="%FREEPASCAL_HOME%\bin\i386-win32\"
    )
)

call "%COMPILER_PATH:"=%fpc.exe" -Cs67107839 -Mdelphi -XS -vm3018 Runner.dpr -o%name%.exe 1>compilation.log

if exist Runner.exe (
    move /Y Runner.exe %name%.exe
)
