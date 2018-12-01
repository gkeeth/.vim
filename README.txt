The entire ~/.vim/ directory is under git version control
plugins are added as git submodules

Installing plugins:
$ git submodule add https://github.com/foo/bar.git pack/plugins/start/bar

or, for optionally loaded plugin:
$ git submodule add https://github.com/foo/bar.git pack/plugins/opt/bar

Installing additional filetype info:
add to .vim/after/ftplugin/
(goes in after/ftplugin/ so that it will not be overridden by other settings)

Filetypes also need to be detected correctly. Installing ftdetect plugins:
put in .vim/ftdetect/

