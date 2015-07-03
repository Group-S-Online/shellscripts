@echo off
	for /D %%d in ("*") do @( 
		@if exist "%%d\Gruntfile.js" (
			call in-dir "%%d" : %*
			echo.
			echo.
			echo.
		)
	)
@echo on