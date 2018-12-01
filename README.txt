The entire ~/.vim/ directory is under git version control.
Plugins are added as git submodules.


Installing plugins:
$ git submodule add https://github.com/foo/bar.git pack/plugins/start/bar
$ git commit -m "Added submodules"

or, for optionally loaded plugin:
$ git submodule add https://github.com/foo/bar.git pack/plugins/opt/bar
$ git commit -m "Added submodules"


Updating a plugin:
cd ~/.vim/pack/plugins/start/foo/
$ git pull origin master
alternatively,
$ git fetch origin master
then review changes and merge.

Updating all plugins:
$ cd ~/.vim/
$ git submodule foreach git pull origin master

After updating plugins, commit changes made to .vim:
$ cd ~/.vim
$ git commit -am "updated plugins"


Removing a plugin:
$ cd ~/.vim
$ git submodule deinit pack/plugins/start/foo
$ git rm -r pack/plugins/start/foo
$ rm -r .git/modules/pack/plugins/start/foo


Installing additional filetype info:
add to .vim/after/ftplugin/
(goes in after/ftplugin/ so that it will not be overridden by other settings)

Filetypes also need to be detected correctly. Installing ftdetect plugins:
put in .vim/ftdetect/


Replicating .vim on a new machine:
$ git clone --recursive https://github.com/gkeeth/.vim.git
$ vim
then :helptags ALL


Updating .vim from remote:
$ cd ~/.vim
$ git pull
$ git submodule update
