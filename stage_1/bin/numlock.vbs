CreateObject("Wscript.Shell").Run("powershell -windowstyle hidden -noninteractive -command "" if(-not [console]::NumberLock){(New-Object -ComObject WScript.Shell).SendKeys('{NUMLOCK}'); } "" "),0