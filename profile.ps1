Set-PSReadlineOption -BellStyle None
# if (Get-Module -Name posh-git -ListAvailable) {Import-Module posh-git}

Remove-Item Alias:gc -Force
Remove-Item Alias:gl -Force
Remove-Item Alias:gp -Force

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
