@echo off
	for /D %%d in ("*") do @( 
		@if exist "%%d\.git" (
			call in-dir "%%d" : %*
			echo.
			echo.
			echo.
		)
	)
@echo on