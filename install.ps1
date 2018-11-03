$DOTFILES = Split-Path -Parent $PSCommandPath

$FILES = (
    ("ackrc", ".ackrc"),
    ("vimrc", ".vimrc"),
    ("gitignore", ".gitignore"),
    ("gitconfig", ".gitconfig"),
    ("profile.ps1", "Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1")
)

$DIRECTORIES = (
    ("vim", ".vim"),
    ("vim", "vimfiles")
)

foreach ($pair in $FILES) {
    $source = "$DOTFILES\$($pair[0])"
    $destination = "$HOME\$($pair[1])"
    Write-Host "Linking $destination..."
    if (Test-Path $destination) {Remove-Item $destination}
    cmd /c mklink $destination $source > $null
}

foreach ($pair in $DIRECTORIES) {
    $source = "$DOTFILES\$($pair[0])"
    $destination = "$HOME\$($pair[1])"
    Write-Host "Linking $destination..."
    $file = Get-Item $destination -Force -ErrorAction SilentlyContinue
    if ($file) {$file.Delete()}
    cmd /c mklink /J $destination $source > $null
}

Write-Host "Downloading ~\vimfiles\autoload\plug.vim..."
$autoload = New-Item -ItemType Directory -Force -Path $HOME\vimfiles\autoload
$url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile($url, "$autoload\plug.vim")

Write-Host "Installing vim plugins..."
gvim +PlugInstall +qall

Write-Host "Installing scoop..."
Invoke-Expression (New-Object Net.WebClient).DownloadString('https://get.scoop.sh')
