del *.h
del advcartridge
del make.bat
..\..\bin\script_compiler.exe accuse.hjt
if %ERRORLEVEL% EQU 0 (
	pause
) else (
	pause
	call make ../../bin/storytllr64.prg
	bin\accusec64.d64
)