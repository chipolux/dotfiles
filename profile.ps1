# Set-PSReadlineOption -BellStyle None
# if (Get-Module -Name posh-git -ListAvailable) {Import-Module posh-git}

Remove-Item Alias:cat -Force
Remove-Item Alias:cp -Force
Remove-Item Alias:curl -Force
Remove-Item Alias:diff -Force
Remove-Item Alias:gc -Force
Remove-Item Alias:gl -Force
Remove-Item Alias:gp -Force
Remove-Item Alias:ls -Force
Remove-Item Alias:mv -Force
Remove-Item Alias:pwd -Force
Remove-Item Alias:rm -Force
Remove-Item Alias:sort -Force
Remove-Item Alias:tee -Force
Remove-Item Alias:type -Force
# Remove-Item Alias:vim -Force
Remove-Item Alias:wget -Force
Remove-Item Alias:where -Force

Set-Alias -Name vim -Value nvim
Set-Alias -Name gvim -Value nvim-qt

function g {cmd /c $((@("git") + $args) -Join " ")}
function ga {cmd /c $((@("git", "add") + $args) -Join " ")}
function gb {cmd /c $((@("git", "branch") + $args) -Join " ")}
function gc {cmd /c $((@("git", "commit") + $args) -Join " ")}
function gco {cmd /c $((@("git", "checkout") + $args) -Join " ")}
function gd {cmd /c $((@("git", "diff") + $args) -Join " ")}
function gl {cmd /c $((@("git", "pull") + $args) -Join " ")}
function gp {cmd /c $((@("git", "push") + $args) -Join " ")}
function gst {cmd /c $((@("git", "status") + $args) -Join " ")}

function of {start $(fzf --height 10)}
function vf {vim $(fzf --height 10)}
function gvf {gvim $(fzf --hright 10)}

function ll {cmd /c $((@("ls", "-lh") + $args) -Join " ")}

function Open-Port {
    param ($Name, $BaudRate=9600, $Parity="None", $DataBits=8, $StopBits="One")
    return New-Object System.IO.Ports.SerialPort $Name,$BaudRate,$Parity,$DataBits,$StopBits
}

function WriteLine-Port {
    param ($Port, $Message)
    $Port.WriteLine($Message)
    return $Port.ReadExisting()
}

# source minecraft resize function
if (Test-Path -PathType Leaf -Path "D:\Tools\Resize-Minecraft.ps1") {
    . D:\Tools\Resize-Minecraft.ps1
}

# Setup function to activate ESP-IDF environment, need to update the IdfId when
# newer version of the framework are installed, appears to be commit hash?
function activate-esp {
    . C:\Espressif\Initialize-Idf.ps1 -IdfId esp-idf-6d46fc4ab0112ff48bc13dba62835e72
}

# Setup function to activate Visual Studio dev shell (access to CL, etc.), need
# to update module path and version hash when new releases are installed.
function activate-vs {
     Import-Module "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
     Enter-VsDevShell 6b1f3f5f
}

# Setup function to activate virtualenv
function activate-venv {
    $ProjectDir = $(git rev-parse --show-toplevel 2>$null)
    if ($ProjectDir) {
        $ProjectDir = $ProjectDir.Replace("/", "\") + "\"
    } else {
        $ProjectDir = $(Get-Location).Path + "\"
    }
    $ProjectName = Split-Path $ProjectDir -Leaf
    $ActivateScripts = @(
        $("{0}.env\Scripts\Activate.ps1" -f $ProjectDir),
        $("{0}.venv\Scripts\Activate.ps1" -f $ProjectDir),
        $("{0}env\Scripts\Activate.ps1" -f $ProjectDir),
        $("{0}venv\Scripts\Activate.ps1" -f $ProjectDir)
    )
    foreach ($Script in $ActivateScripts) {
        if (Test-Path -Path $Script) {
            . $Script -Prompt $ProjectName
            break
        }
    }
}

if (Test-Path ~\.dotfiles\private-profile.ps1) {
    . ~\.dotfiles\private-profile.ps1
}
