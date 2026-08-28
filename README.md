# QuickZsh
## Introduction
This project is a set of zsh configs with out framwork.   
Normally, you can run `./setup_zsh.sh` to install it,   
or use `./setup_zsh.sh -y` to install it without notice.    
The Script will use `doas` or `sudo` smartly.  

This script support these **Linux** distros and **macOS**:
  1. Debian
  2. Arch
  3. Fedora
  4. Void
  5. OpenWRT
  6. Alpine 

## Shortcut Keys
| Keys         | Purpose                             |  
|:------------:|:------------------------------------|
| `Alt+UP`     | History-Subtring-Search-Up          |  
| `Alt+DOWN`   | History-Subtring-Search-Down        |  
| `Shift+UP`   | Up-History                          |  
| `Shift+Down` | Down-History                        |  
| `PageUp`     | Up-History                          |  
| `PageDown`   | Down-Page                           |  
| `Ctrl+R`     | History-Incremental-Search-Backward |  

## Specially Prepared Aliases
### `ls`
#### *If the coammand `eza` exsists*
| Aliases | The command actually executed |
|:-------:|:------------------------------|
| `ls`    | `eza`                         |
| `ll`    | `eza -l`                      |
| `la`    | `eza -A`                      |
| `l`     | `eza -lA`                     |

#### *If you just have the command `ls`*
| Aliases | The command actually executed |
|:-------:|:------------------------------|
| `ls`    | `ls`                          |
| `ll`    | `ls -l`                       |
| `la`    | `ls -A`                       |
| `l`     | `ls -lAh`                     |

### `..` (Switch to parent directory(ies))
| Aliases | The command actually executed |
|:-------:|:------------------------------|
| `..`    | `cd ..`                       |
| `...`   | `cd ../..`                    |
| `....`  | `cd ../../..`                 |
| . . .   | . . .                         |
| `......`| `cd ../../../../..`           |

### Colored Outputs
| Aliases | The command actually executed |
|:-------:|:------------------------------|
| `grep`  | `grep --color=auto`           |
| `ip`    | `ip --color=auto`             |

> BTW, You can add more aliases which can make your commands have colored output.

### Others
| Aliases | The command actually executed |
|:-------:|:------------------------------|
| `cls`   | `clear`                       |

## Plugins the config will load
1. [Zsh-Syntax-Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting.git)
2. [Zsh-Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions.git)
3. [Zsh-History-Substring-Search](https://github.com/zsh-users/zsh-history-substring-search.git)
4. [Powerlevel10k](https://github.com/romkatv/powerlevel10k.git) 

## How to install?
### Way 1 - Cloning the Repository
#### If your system is supported *original script*(`setup_zsh.sh`)
> Make sure you have these package on your system: `bash`, `git`, `curl`, `wget`, `shadow`
1. Clone the repository

```sh
git clone https://github.com/BiaoZyx/QuickZsh.git
```

2. Install it
```sh
cd QuickZsh
./setup_zsh.sh
```

3. Change your login shell back (Optional, if you don't want to use zsh as your default login shell)  
At first, you should check the available shells in your system:
```sh
cat /etc/shells
```

The output will look like this: (From my system - Alpine Linux)
```sh
# valid login shells
/bin/sh
/bin/ash
/bin/zsh
/bin/bash
```

And change it, such as:
```sh
chsh -s /usr/bin/bash  # Bash - 1
chsh -s /bin/bash      # Bash - 2

chsh -s /usr/bin/fish  # Fish - 1
chsh -s /bin/fish      # Fish - 2

chsh -s /usr/bin/ksh   # Ksh  - 1
chsh -s /bin/ksh       # Ksh  - 2

# ...
```

#### Or your system is Alpine Linux:
Out of my fondness for Alpine Linux, I customized the installation script for Alpine.
So you can first follow the steps above, and then run `./setup_zsh-alpine.sh` rather tan `./setup_zsh.sh`.
It will automatically install plugins from the Alpine repository instead of using the git repository. Of course, if you prefer to use the git version of the plugins, you can also use the original script, as I have also added support for Alpine to the original script.
It is worth mentioning that the Alpine version's script use ash shell scripts instead of bash shell scripts.

### Way 2 - Using the remote link of my Pages website(my blog site)
- The original version:
```sh
curl https://biaozyx.pages.dev/scripts/setup_zsh.sh | bash
```

- Alpine version:
```sh
curl https://biaozyx.pages.dev/scripts/setup_zsh-alpine.sh | sh
```
