del *.h
del advcartridge
del make.bat
..\..\bin\script_compiler.exe sample.hjt
if %ERRORLEVEL% EQU 0 (
	pause
) else (
	pause
	call make ../../bin/storytllr64.prg
	bin\sampleadventure.d64
)