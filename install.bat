@echo off

:: backup old vimrc and link in current
if exist %USERPROFILE%\.vimrc (
    move /Y %USERPROFILE%\.vimrc %USERPROFILE%\.vimrc_old
)
mklink /H %USERPROFILE%\.vimrc vimrc

:: get vim-plug and put it in place
if not exist vim\autoload\plug.vim (
    git clone --depth 1 https://github.com/junegunn/vim-plug.git vim\autoload\vim-plug
    copy /Y vim\autoload\vim-plug\plug.vim  vim\autoload\plug.vim
    rmdir /S /Q vim\autoload\vim-plug
)
if exist %USERPROFILE%\.vim (
    move /Y %USERPROFILE%\.vim %USERPROFILE%\.vim_old
)
mklink /J %USERPROFILE%\.vim vim
mklink /J %USERPROFILE%\vimfiles vim

:: link git stuff
if exist %USERPFORILE%\.gitignore (
    move /Y %USERPROFILE%\.gitignore %USERPROFILE%\.gitignore_old
)
mklink /H %USERPROFILE%\.gitignore gitignore
if exist %USERPFORILE%\.gitconfig (
    move /Y %USERPROFILE%\.gitconfig %USERPROFILE%\.gitconfig_old
)
mklink /H %USERPROFILE%\.gitconfig gitconfig

:: install vim plugins
gvim +PlugInstall +qall
