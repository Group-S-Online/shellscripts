@echo off
	
	set BANNER1=-- %~1
	set BANNER2=------------------------------------------------

	cd "%1"

		echo %BANNER2:~0,45%
		echo %BANNER1:~0,45%
		echo %BANNER2:~0,45%
	
		for /f "tokens=1,* delims=:" %%a in ("%*") do ( 
			@echo on  &&  call %%b  && @echo off 
		)
		
		echo %BANNER2:~0,45%

		
	cd ..
@echo on