if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "Run as admin!"
}

echo "=== Stage 3 ==="

echo "=== Configuring Powershell and Winget ==="
./powershell_winget.ps1

echo "=== Configuring Windows Features ==="
./windows_features.ps1

echo "=== Installing Chocolatey ==="
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco feature enable -n=allowGlobalConfirmation

echo "=== Installing Chocolatey packages ==="
choco install choco_packages.config

echo "=== Installing PROBLEMATIC Chocolatey packages (requires attention!) ==="
choco install choco_problematic_packages.config

echo "=== Set edit with Notepad++ ==="
reg import edit_with_npp.reg

echo "=== Pinning taskbar defaults ==="
./start_taskbar_pin.ps1

echo "=== Setting wallpaper ==="
./wallpaper.ps1

echo "=== Running other tweaks ==="
# SSD life improvement
fsutil behavior set DisableLastAccess 1
fsutil behavior set EncryptPagingFile 0
# privacy
Set-WindowsSearchSetting -EnableWebResultsSetting $false

echo "=== Done! ==="