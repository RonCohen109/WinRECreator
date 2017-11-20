@shift /0
@echo off
title WinRE Creator
echo Note: This method will only work if the directory is not mounted and it is WinPE 5.0!
echo WinPE 5.0 is Windows 8 PE.
echo This will not work otherwise.
set /p image=What is the directory name? 
Dism /Mount-Image /ImageFile:"C:\%image%\media\sources\boot.wim" /index:1 /MountDir:"C:\%image%\mount"
Dism /Add-Package /Image:"C:\%image%\mount" /PackagePath:WinPE-WMI.cab
Dism /Add-Package /Image:"C:\%image%\mount" /PackagePath:WinPE-WMI_en-us.cab
Dism /Add-Package /Image:"C:\%image%\mount" /PackagePath:WinPE-Scripting.cab
Dism /Add-Package /Image:"C:\%image%\mount" /PackagePath:WinPE-Scripting_en-us.cab
Dism /Add-Package /Image:"C:\%image%\mount" /PackagePath:WinPE-MDAC.cab
Dism /Add-Package /Image:"C:\%image%\mount" /PackagePath:WinPE-MDAC_en-us.cab
Dism /Add-Package /Image:"C:\%image%\mount" /PackagePath:WinPE-HTA.cab
Dism /Add-Package /Image:"C:\%image%\mount" /PackagePath:WinPE-HTA_en-us.cab
md c:\%image%\mount\Tools
copy Wimscript.ini C:\%image%\mount\Tools
copy imagex.exe C:\%image%\mount\Tools
dism /unmount-wim /mountdir:C:\%image%\mount /commit
OSCDimg.exe -n -bC:\%image%\fwfiles\etfsboot.com C:\%image%\media C:\winre.iso
echo Done!
echo WinRE Image Saved as C:\winre.iso
echo Press any key to exit...
pause >nul
