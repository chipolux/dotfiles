# Script to download and install my favorite tools on Windows

function Install-App([String] $Name, [String] $Path, [String] $Arguments, [String] $Url) {
    if (-not (Test-Path $Path)) {
        if (-not (Test-Path "$env:TMP\$Name-installer.exe")) {
            Write-Host "Downloading $Name..."
            $wc = New-Object System.Net.WebClient
            $wc.DownloadFile($Url, "$env:TMP\$Name-installer.exe")
        }
        Write-Host "Installing $Name..."
        Start-Process -FilePath $env:TMP\$Name-installer.exe -ArgumentList $Arguments -Wait
    }
}

function Update-Path([String] $Name, [String] $Component) {
    $UserPath = [Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::User)
    $UserPath = $UserPath.Split(";", [StringSplitOptions]::RemoveEmptyEntries)
    if (-not ($UserPath -contains $Component)) {
        Write-Host "Adding $Name to the path..."
        $NewPath = ($UserPath + $Component) -join ";"
        [Environment]::SetEnvironmentVariable("PATH", $NewPath, [EnvironmentVariableTarget]::User)
    }
}

Install-App -Name "Python" `
            -Path "C:\Python36\python.exe" `
            -Arguments "/passive TargetDir=C:\Python36 Include_launcher=0" `
            -Url "https://www.python.org/ftp/python/3.6.4/python-3.6.4-amd64.exe"
Update-Path -Name "Python" -Component "C:\Python36\"
Update-Path -Name "Python Scripts" -Component "C:\Python36\Scripts\"

Install-App -Name "Make" `
            -Path "C:\Program Files (x86)\GnuWin32\bin\make.exe" `
            -Arguments "/SILENT" `
            -Url "https://downloads.sourceforge.net/project/gnuwin32/make/3.81/make-3.81.exe?use_mirror=pilotfiber"
Update-Path -Name "Make" -Component "C:\Program Files (x86)\GnuWin32\bin\"

Install-App -Name "Git" `
            -Path "C:\Program Files\Git\cmd\git.exe" `
            -Arguments "/SILENT" `
            -Url "https://github.com/git-for-windows/git/releases/download/v2.15.1.windows.2/Git-2.15.1.2-64-bit.exe"
Update-Path -Name "Git" -Component "C:\Program Files\Git\cmd\"

Install-App -Name "GVim" `
            -Path "C:\Program Files (x86)\Vim\vim80\gvim.exe" `
            -Url "ftp://ftp.vim.org/pub/vim/pc/gvim80-586.exe"
