function Show-Menu {
    param (
        [string]$title = 'Menu'
    )
    cls
    Write-Host "==================== $title ===================="
    Write-Host "1: Developer Tools (Unity Hub, Visual Studio, Git, GitHub Desktop, Plastic SCM Cloud)"
    Write-Host "2: General Software (Python, Visual Studio Code, VSCode Insiders, PyCharm, Ruby, Notepad++)"
    Write-Host "3: Communications (Slack, Discord, Guilded, Telegram)"
    Write-Host "4: Browsers (Google Chrome, Mozilla Firefox, Firefox ESR)"
    Write-Host "5: Utilities (Windows Terminal, 7-Zip, JDownloader2, Tixati, Awesun Aweray)"
    Write-Host "6: Office and Security (Office 365 Insider, Kaspersky Premium, fxSound)"
    Write-Host "0: Exit"
}

function Install-DeveloperTools {
    Write-Output "Downloading and installing Unity Hub..."
    Invoke-WebRequest -Uri $unityHubUrl -OutFile "$env:TEMP\UnityHubSetup.exe"
    Start-Process -FilePath "$env:TEMP\UnityHubSetup.exe" -ArgumentList "/S" -Wait

    Write-Output "Downloading and installing Visual Studio..."
    Invoke-WebRequest -Uri $visualStudioUrl -OutFile "$env:TEMP\vs_community.exe"
    Start-Process -FilePath "$env:TEMP\vs_community.exe" -ArgumentList "--add Microsoft.VisualStudio.Workload.ManagedDesktop --includeRecommended --passive --norestart" -Wait

    Write-Output "Downloading and installing Git..."
    Invoke-WebRequest -Uri $gitUrl -OutFile "$env:TEMP\GitSetup.exe"
    Start-Process -FilePath "$env:TEMP\GitSetup.exe" -ArgumentList "/SILENT" -Wait

    Write-Output "Downloading and installing GitHub Desktop..."
    Invoke-WebRequest -Uri $githubDesktopUrl -OutFile "$env:TEMP\GitHubDesktopSetup.exe"
    Start-Process -FilePath "$env:TEMP\GitHubDesktopSetup.exe" -ArgumentList "/S" -Wait

    Write-Output "Downloading and installing Plastic SCM Cloud..."
    Invoke-WebRequest -Uri $plasticSCMUrl -OutFile "$env:TEMP\PlasticSCMSetup.exe"
    Start-Process -FilePath "$env:TEMP\PlasticSCMSetup.exe" -ArgumentList "/S" -Wait
}

function Install-GeneralSoftware {
    Write-Output "Downloading and installing Python..."
    Invoke-WebRequest -Uri $pythonUrl -OutFile "$env:TEMP\PythonSetup.exe"
    Start-Process -FilePath "$env:TEMP\PythonSetup.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

    Write-Output "Downloading and installing Visual Studio Code..."
    Invoke-WebRequest -Uri $vsCodeUrl -OutFile "$env:TEMP\VSCodeSetup.exe"
    Start-Process -FilePath "$env:TEMP\VSCodeSetup.exe" -ArgumentList "/verysilent" -Wait

    Write-Output "Downloading and installing VSCode Insiders..."
    Invoke-WebRequest -Uri $vsCodeInsidersUrl -OutFile "$env:TEMP\VSCodeInsidersSetup.exe"
    Start-Process -FilePath "$env:TEMP\VSCodeInsidersSetup.exe" -ArgumentList "/verysilent" -Wait

    Write-Output "Downloading and installing PyCharm..."
    Invoke-WebRequest -Uri $pyCharmUrl -OutFile "$env:TEMP\PyCharmSetup.exe"
    Start-Process -FilePath "$env:TEMP\PyCharmSetup.exe" -ArgumentList "/S" -Wait

    Write-Output "Downloading and installing Ruby..."
    Invoke-WebRequest -Uri $rubyUrl -OutFile "$env:TEMP\RubyInstaller.exe"
    Start-Process -FilePath "$env:TEMP\RubyInstaller.exe" -ArgumentList "/verysilent" -Wait

    Write-Output "Downloading and installing Notepad++..."
    Invoke-WebRequest -Uri $notepadPlusPlusUrl -OutFile "$env:TEMP\NotepadPlusPlusSetup.exe"
    Start-Process -FilePath "$env:TEMP\NotepadPlusPlusSetup.exe" -ArgumentList "/S" -Wait
}

function Install-Communications {
    Write-Output "Downloading and installing Slack..."
    $slackUrl = "https://downloads.slack-edge.com/releases/windows/4.27.154/prod/x64/SlackSetup.exe"
    Invoke-WebRequest -Uri $slackUrl -OutFile "$env:TEMP\SlackSetup.exe"
    Start-Process -FilePath "$env:TEMP\SlackSetup.exe" -ArgumentList "/S" -Wait

    Write-Output "Downloading and installing Discord..."
    $discordUrl = "https://discord.com/api/download?platform=win"
    Invoke-WebRequest -Uri $discordUrl -OutFile "$env:TEMP\DiscordSetup.exe"
    Start-Process -FilePath "$env:TEMP\DiscordSetup.exe" -ArgumentList "/S" -Wait

    Write-Output "Downloading and installing Guilded..."
    $guildedUrl = "https://www.guilded.gg/downloads/GuildedSetup.exe"
    Invoke-WebRequest -Uri $guildedUrl -OutFile "$env:TEMP\GuildedSetup.exe"
    Start-Process -FilePath "$env:TEMP\GuildedSetup.exe" -ArgumentList "/S" -Wait

    Write-Output "Downloading and installing Telegram..."
    $telegramUrl = "https://telegram.org/dl/desktop/win"
    Invoke-WebRequest -Uri $telegramUrl -OutFile "$env:TEMP\TelegramSetup.exe"
    Start-Process -FilePath "$env:TEMP\TelegramSetup.exe" -ArgumentList "/S" -Wait
}

function Install-Browsers {
    Write-Output "Downloading and installing Google Chrome..."
    $chromeUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
    Invoke-WebRequest -Uri $chromeUrl -OutFile "$env:TEMP\ChromeSetup.exe"
    Start-Process -FilePath "$env:TEMP\ChromeSetup.exe" -ArgumentList "/silent /install" -Wait

    Write-Output "Downloading and installing Mozilla Firefox..."
    $firefoxUrl = "https://download.mozilla.org/?product=firefox-latest&os=win&lang=en-US"
    Invoke-WebRequest -Uri $firefoxUrl -OutFile "$env:TEMP\FirefoxSetup.exe"
    Start-Process -FilePath "$env:TEMP\FirefoxSetup.exe" -ArgumentList "/S" -Wait

    Write-Output "Downloading and installing Firefox ESR..."
    $firefoxEsrUrl = "https://download.mozilla.org/?product=firefox-esr-latest&os=win&lang=en-US"
    Invoke-WebRequest -Uri $firefoxEsrUrl -OutFile "$env:TEMP\FirefoxEsrSetup.exe"
    Start-Process -FilePath "$env:TEMP\FirefoxEsrSetup.exe" -ArgumentList "/S" -Wait
}

function Install-Utilities {
    Write-Output "Downloading and installing Windows Terminal..."
    Invoke-WebRequest -Uri $windowsTerminalUrl -OutFile "$env:TEMP\WindowsTerminal.msixbundle"
    Add-AppxPackage -Path "$env:TEMP\WindowsTerminal.msixbundle"

    Write-Output "Downloading and installing 7-Zip..."
    $sevenZipUrl = "https://www.7-zip.org/a/7z1900-x64.msi"
    Invoke-WebRequest -Uri $sevenZipUrl -OutFile "$env:TEMP\7ZipSetup.msi"
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $env:TEMP\7ZipSetup.msi /qn" -Wait

    Write-Output "Downloading and installing JDownloader2..."
    $jdownloaderUrl = "http://installer.jdownloader.org/JDownloader2Setup.exe"
    Invoke-WebRequest -Uri $jdownloaderUrl -OutFile "$env:TEMP\JDownloader2Setup.exe"
    Start-Process -FilePath "$env:TEMP\JDownloader2Setup.exe" -ArgumentList "/S" -Wait

    Write-Output "Downloading and installing Tixati..."
    $tixatiUrl = "https://download2.tixati.com/download/tixati-2.89-1.win64-install.exe"
    Invoke-WebRequest -Uri $tixatiUrl -OutFile "$env:TEMP\TixatiSetup.exe"
    Start-Process -FilePath "$env:TEMP\TixatiSetup.exe" -ArgumentList "/S" -Wait

    Write-Output "Downloading and installing Awesun Aweray..."
    $awesunUrl = "https://download.aweray.com/AwerayRemote_setup.exe"
    Invoke-WebRequest -Uri $awesunUrl -OutFile "$env:TEMP\AwesunSetup.exe"
    Start-Process -FilePath "$env:TEMP\AwesunSetup.exe" -ArgumentList "/S" -Wait
}

function Install-OfficeAndSecurity {
    Write-Output "Downloading and installing Office 365 Insider..."
    $office365Url = "https://go.microsoft.com/fwlink/p/?linkid=2124703"
    Invoke-WebRequest -Uri $office365Url -OutFile "$env:TEMP\Office365Setup.exe"
    Start-Process -FilePath "$env:TEMP\Office365Setup.exe" -ArgumentList "/S" -Wait

    Write-Output "Downloading and installing Kaspersky Premium..."
    $kasperskyUrl = "https://www.kaspersky.com/downloads/thank-you/antivirus-downloads"
    Invoke-WebRequest -Uri $kasperskyUrl -OutFile "$env:TEMP\KasperskySetup.exe"
    Start-Process -FilePath "$env:TEMP\KasperskySetup.exe" -ArgumentList "/S" -Wait

    Write-Output "Downloading and installing fxSound..."
    $fxSoundUrl = "https://www.fxsound.com/installers/fxsound_setup.exe"
    Invoke-WebRequest -Uri $fxSoundUrl -OutFile "$env:TEMP\fxSoundSetup.exe"
    Start-Process -FilePath "$env:TEMP\fxSoundSetup.exe" -ArgumentList "/S" -Wait
}

# Main script
$unityHubUrl = "https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup.exe"
$visualStudioUrl = "https://aka.ms/vs/17/release/vs_community.exe"
$gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.40.0.windows.1/Git-2.40.0-64-bit.exe"
$githubDesktopUrl = "https://central.github.com/deployments/desktop/desktop/latest/win32"
$plasticSCMUrl = "https://www.plasticscm.com/download/11.0.16.7438/plasticscm_installer_11.0.16.7438.exe"
$pythonUrl = "https://www.python.org/ftp/python/3.10.5/python-3.10.5-amd64.exe"
$vsCodeUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
$vsCodeInsidersUrl = "https://update.code.visualstudio.com/latest/win32-x64/insider"
$pyCharmUrl = "https://download.jetbrains.com/python/pycharm-community-2022.1.4.exe"
$rubyUrl = "https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.1.2-1/rubyinstaller-devkit-3.1.2-1-x64.exe"
$notepadPlusPlusUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.2/npp.8.4.2.Installer.x64.exe"
$windowsTerminalUrl = "https://github.com/microsoft/terminal/releases/download/v1.15.2874.0/Microsoft.WindowsTerminal_1.15.2874.0_8wekyb3d8bbwe.msixbundle"

while ($true) {
    Show-Menu
    $choice = Read-Host "Enter your choice"

    switch ($choice) {
        0 { break }
        1 { Install-DeveloperTools }
        2 { Install-GeneralSoftware }
        3 { Install-Communications }
        4 { Install-Browsers }
        5 { Install-Utilities }
        6 { Install-OfficeAndSecurity }
        default { Write-Host "Invalid choice, please try again." }
    }
}

Write-Output "Cleaning up..."
Remove-Item "$env:TEMP\UnityHubSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\vs_community.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\GitSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\GitHubDesktopSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\PlasticSCMSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\PythonSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\VSCodeSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\VSCodeInsidersSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\PyCharmSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\RubyInstaller.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\NotepadPlusPlusSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\SlackSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\DiscordSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\GuildedSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\TelegramSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\ChromeSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\FirefoxSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\FirefoxEsrSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\WindowsTerminal.msixbundle" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\7ZipSetup.msi" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\JDownloader2Setup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\TixatiSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\AwesunSetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\Office365Setup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\KasperskySetup.exe" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\fxSoundSetup.exe" -ErrorAction SilentlyContinue

Write-Output "Installation complete!"
