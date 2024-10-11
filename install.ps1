# System Prep
# 1. Install scoop
# 2. scoop bucket add extras
# 3. scoop install git neovim alacritty wget curl fd ripgrep fzf python uutils-coreutils
#
# May need to Unblock-File on the profile script if it gets marked as from the "scary internet"

$DOTFILES = Split-Path -Parent $PSCommandPath

$FILES = (
    ("ackrc", ".ackrc"),
    ("vimrc", "AppData\nvim\init.vim"),
    ("vimrc", "AppData\Local\nvim\init.vim"),
    ("vimrc", ".vimrc"),
    ("gitignore", ".gitignore"),
    ("gitconfig", ".gitconfig"),
    ("profile-shim.ps1", "Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1")
)

$DIRECTORIES = (
    ("vim", ".vim"),
    ("vim", "vimfiles")
)

foreach ($pair in $FILES) {
    $source = "$DOTFILES\$($pair[0])"
    $destination = "$HOME\$($pair[1])"
    Write-Host "Linking $destination..."
    New-Item $destination -ItemType Directory -Force
    if (Test-Path $destination) {Remove-Item $destination -Force -Recurse}
    Copy-Item -Path $source -Destination $destination -Force -Recurse
    # New-Item -Path $destination -Value $source -ItemType HardLink -Force
    # cmd /c mklink $destination $source > $null
}

foreach ($pair in $DIRECTORIES) {
    $source = "$DOTFILES\$($pair[0])"
    $destination = "$HOME\$($pair[1])"
    Write-Host "Linking $destination..."
    if (-not (Test-Path $source)) {New-Item $source -ItemType Directory -Force}
    New-Item $destination -ItemType Directory -Force
    $file = Get-Item $destination -Force -ErrorAction SilentlyContinue
    if ($file) {Remove-Item $destination -Force -Recurse}
    Copy-Item -Path $source -Destination $destination -Force
    # New-Item -Path $destination -Value $source -ItemType Junction -Force
    # cmd /c mklink /J $destination $source > $null
}

Write-Host "Downloading ~\vimfiles\autoload\plug.vim..."
# for vim
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force
# for neovim
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

Write-Host "Installing vim plugins..."
nvim +PlugInstall +qall

#Write-Host "Installing scoop..."
#Invoke-Expression (New-Object Net.WebClient).DownloadString('https://get.scoop.sh')
