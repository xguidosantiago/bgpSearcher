@echo off

setlocal enabledelayedexpansion
set "var=%1"
set "var_nopoints=!var:.=!"
set "var_nochar=!var::=!"


if "%1"=="" (
	echo.
    echo  [+]INFO: Provide ASN or IPv4/Ipv6 Address to search
	echo   example 1: bgps 22927
	echo   example 2: bgps 200.26.106.0
	echo   example 3: bgps 2800:381::
	echo.
) else if "%var_nopoints%"=="%var%" (
	if "%var_nochar%"=="%var%" (
		set /a count=0
		set "url=https://bgpview.io/asn/%1"
		echo.
		
		for /f "tokens=*" %%a in ('curl -s "!url!" ^| findstr "owner:"') do (
			set "owner=%%a"
		   echo  !owner!
		)

		for /f "tokens=*" %%b in ('curl -s "!url!" ^| findstr "aut-num:"') do (
		   set asn=%%b
		   echo  !asn!
		)
		REM echo ________________________________________
		echo.
		echo  Prefixes:
		for /f "tokens=3 delims=' " %%a in ('curl -s "!url!" ^| findstr "prefix':"') do (
			set prefix=%%a
			echo   !prefix!
			set /a count+=1
		)
		  echo.
		echo  Total:!count!
		REM echo ________________________________________
		echo.
		) else ( 
		goto ips
		)
	) else (
	:ips
	echo %1 | find "/" >nul
    if errorlevel 1 (
	echo.
		
		for /f "tokens=1 delims=" %%a in ('curl -s https://api.bgpview.io/ip/%1') do (
		  set encontrado_prefix=0
		  set encontrado_cidr=0
		  set encontrado_asn=0
		  set encontrado_name=0
		  set encontrado_country=0
		  set encontrado_desc=0
		  
			for %%b in (%%a) do (
			if "!encontrado_prefix!"=="0" (
			echo %%b | find /i "ip" >nul && (
			 set "line=%%b"
			 set "line=!line:{=!"
			 set "line=!line:}=!"
			 set "line=!line: "=!"
			 set "line=!line:"=!"
			 echo  !line!
			 set encontrado_prefix=1
					)
				)
			)
			for %%b in (%%a) do (
			if "!encontrado_cidr!"=="0" (
			echo %%b | find /i "cidr" >nul && (
			 set "line=%%b"
			 set "line=!line:{=!"
			 set "line=!line:}=!"
			 set "line=!line: "=!"
			 set "line=!line:"=!"
			 echo  !line!
			 set encontrado_cidr=1
					)
				)
			)
			
			for %%b in (%%a) do (
			if "!encontrado_asn!"=="0" (
			echo %%b | find /i "asn" >nul && (
			 set "line=%%b"
			 set "line=!line:{=!"
			 set "line=!line:}=!"
			 set "line=!line: "=!"
			 set "line=!line:"=!"
			 echo  !line!
			 set encontrado_asn=1
					)
				)
			)
			
			for %%b in (%%a) do (
			if "!encontrado_name!"=="0" (
			echo %%b | find /i "name" >nul && (
			 set "line=%%b"
			 set "line=!line:{=!"
			 set "line=!line:}=!"
			 set "line=!line: "=!"
			 set "line=!line:"=!"
			 echo  !line!
			 set encontrado_name=1
					)
				)
			)
			for %%b in (%%a) do (
			if "!encontrado_desc!"=="0" (
			echo %%b | find /i "description" >nul && (
			 set "line=%%b"
			 set "line=!line:{=!"
			 set "line=!line:}=!"
			 set "line=!line: "=!"
			 set "line=!line:"=!"
			 echo  !line!
			 set encontrado_desc=1
					)
				)
			)
			
			for %%b in (%%a) do (
			if "!encontrado_country!"=="0" (
			echo %%b | find /i "country_code" >nul && (
			 set "line=%%b"
			 set "line=!line:{=!"
			 set "line=!line:}=!"
			 set "line=!line: "=!"
			 set "line=!line:"=!"
			 echo  !line!
			 set encontrado_country=1
					)
				)
			)
		)

	echo.
	)	else (
	echo.
	echo  [+] Please do not add subnet mask, only IP address
	echo.
	)
) 
	
		






