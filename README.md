# Installation steps
1. Install [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-download)
2. Add nvim folder to the following places according to your OS:
    - Linux/Mac OS: ~/.config/nvim
    - Windows: %userprofile%\AppData\Local\nvim
Once done, run the following command in the folder:

```
git clone https://github.com/Hiten-Tandon/neovim-config .
```
After this, if this is your first neovim config, you probably want to install nerdfonts, I use the VictorMono nerd font, so I'm adding a way to install that, if you want any other nerdfonts, you can install them from your package manager of choice.

Windows:
`choco install nerd-font-victormono`
Linux:
`sudo apt install nerd-font-victormono`
MacOS:
`brew install --cask font-victor-mono`

Then start neovim, and you should be good to go.

## Note for Windows users:
You need the [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal) available on msstore to access all the features available in the config
