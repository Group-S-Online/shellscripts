@echo off
	for /D %%d in ("*") do @( 
		call in-dir "%%d" : %*
		echo.
		echo.
		echo.
	)
@echo on