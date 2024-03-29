# Vundle
Install [vundle](https://github.com/VundleVim/Vundle.vim) for plugin management. Follow the instructions on the github page (except you don't need to add the sample .vimrc file, since the vimrc file in this repo already contains the necessary lines).

# YouCompleteMe
On a new machine, make sure to follow installation steps for [YouCompleteMe](https://vimawesome.com/plugin/youcompleteme) (or comment out the plugin)

# Tagbar and easytags
For [Tagbar](https://github.com/majutsushi/tagbar) and [easytags](https://github.com/xolox/vim-easytags/blob/master/INSTALL.md), you need to have some version of ctags installed. Universal ctags is currently the maintained version of this: https://github.com/universal-ctags/ctags

When installing universal-ctags, make sure to add a file for your defaults at `~/.ctags.d/defaults.ctags`. I'd recommend adding the following:
```
--map-javascript=+.jsx
--exclude=node_modules
```

Ideally you wouldn't have to exclude node_modules, but I haven't been able to get it to work when trying to tag node_modules, so I'd rather have something than nothing.

# vim-go
[vim-go](https://github.com/fatih/vim-go) requires installing [go](https://golang.org/). You also need to run the command `:GoInstallBinaries` from within Vim once vim-go is installed in order to get things working

