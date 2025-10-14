# Minecraft-Project

An adaptation of [IBM's Work] - with added tooling.

```commandline
⠀⠀⠀⠀⠀⢀⠠⠐⠉⠁⠂⠄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢸⡍⠒⠤⣀⠀⣀⣤⣿⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢸⡄⢹⣦⠀⣿⣿⣿⣟⠒⠉⠀⠁⠂⠄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⠼⠧⣘⠻⠂⣿⣿⣾⣇⢁⠒⠤⣀⣀⣴⣞⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢰⠯⣀⠀⠀⠀⠉⠒⠿⠛⠁⢸⠸⣷⡆⢸⣿⣿⡏⠂⠄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢸⠸⣆⠉⠶⣀⠀⠀⠀⠀⠀⠸⣀⡉⠇⢸⣿⣏⡷⢀⣰⣾⠀⠀⠀⠀⠀⠀⠀⣀⠶⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢸⠐⢼⡷⣶⡄⠉⠒⠤⢀⠀⠀⠀⠉⠓⢼⣿⣟⣿⡿⣿⣿⠀⠀⠀⣀⠤⠒⠉⠀⠀⠀⠈⠐⠠⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⣸⠤⠚⠋⠉⠓⠤⣀⣷⣤⣉⠒⢤⣴⣾⣿⣟⣿⢾⣟⣿⣽⠤⠒⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠐⠠⢄⠀⠀⠀⠀⠀⠀⠀⠀
⢖⠈⠀⠀⠀⠀⠀⠀⠀⠀⠉⣺⣯⡇⠸⣿⣟⣾⣟⣾⣟⣿⣾⡷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠐⠠⢀⡀⠀⠀⠀
⣆⡉⠒⠤⣀⠀⠀⣀⣤⣶⣿⣿⠿⡇⢘⣿⣯⣷⣿⣻⣾⡷⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠠⠀
⠻⣏⠀⠀⣠⣉⣿⣿⣟⣿⡷⣿⠀⠀⢸⣯⣿⢷⣿⣻⣾⢿⣟⣟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣶
⣧⣼⣻⢳⡼⢿⣿⣷⣻⣯⣿⣿⠀⠂⢸⣿⣯⣿⣿⣻⣽⣿⣿⣏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣴⣿⣿⣿⣿
⠻⠟⣿⣿⣧⣤⣿⣿⣯⡿⠗⠋⠀⠄⢸⣿⣯⣷⡿⣟⣯⣷⣿⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣶⣾⣿⣿⡿⣟⣿⣾⣿
⠀⠀⢸⢈⠙⠻⠟⠋⠁⡀⠄⡈⠐⡈⢸⣿⡿⣽⣿⡿⣟⣿⣽⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣴⣿⣿⣿⣿⣻⣿⣽⣿⡿⣿⣻⣽
⠀⠀⢸⢈⠐⠠⢂⢈⠡⠐⠠⠌⠁⠄⢸⣿⣿⢿⣯⣿⣿⢿⣻⣟⠀⠀⠀⠀⠀⠀⠀⣀⣠⣶⣿⣿⣿⢿⣻⣽⣾⣟⣿⣽⣿⣾⣿⣿⣿⣿
⠀⠀⢸⠀⡌⢑⠠⢠⠘⡀⠡⢀⢃⠂⢸⣿⡿⣿⣿⣷⣿⡿⠟⠋⠀⠀⠀⢀⣤⣴⣿⣿⡿⣟⣯⣿⣻⣿⢿⣻⣽⣿⣻⣯⣷⣿⣷⣿⣯⣿
⠀⠀⢸⠀⡜⠠⢂⠄⢣⠀⢡⠂⠆⠌⢸⣿⣿⢿⣷⣿⣯⠐⠤⣀⣠⣶⣿⣿⡿⣿⣻⣷⣿⢿⣿⣻⣿⣽⣿⡿⣿⣽⣿⣟⣿⣽⣾⣿⣿⣿
⠀⠀⢸⠠⡔⠡⢈⠢⢄⠘⣀⠊⡐⢈⢸⣿⡿⣿⣟⣿⡷⠀⠠⢸⣿⣿⣯⣷⣿⡿⣿⣽⣾⡿⣟⣿⣽⣿⣾⢿⣟⣿⣽⣿⡿⣿⣻⣿⣿⣿
⠀⠀⢸⠰⢆⠁⡆⠶⡈⠰⠀⡆⢱⠀⢸⣿⣿⣿⢿⣿⡿⢀⠰⢸⣿⣷⣿⣏⣷⣿⣿⢿⣹⣿⣿⡿⣿⣾⣿⣿⣿⢿⣏⣿⣿⣿⣿⣿⣿⣿
⠀⠀⢸⢐⠃⡌⡐⠦⣡⠑⡌⡐⣂⠡⢸⣿⣿⡿⣿⣿⣟⠠⢀⢸⣿⡿⣷⣿⢿⣯⣿⡿⣿⣻⣷⣿⣿⣻⣾⣿⣽⣿⡿⣿⣻⣿⣿⣿⢿⠻
⠀⠀⢸⢌⢊⠔⡡⢒⠤⢃⠤⡑⠤⠃⢼⣿⣿⣿⣿⢿⣯⠀⠤⢸⣿⣿⣟⣿⡿⣟⣷⣿⣿⢿⣯⣷⣿⣟⣿⣾⣿⣟⣿⣿⣿⣿⡟⠂⠁⠀
⠀⠀⠈⠛⠢⢎⡐⢣⢘⠢⡑⠬⣁⠏⣸⣿⣿⣿⣾⣿⣿⠀⡐⢸⣿⣷⣿⣻⣿⡿⣿⣻⣾⣿⣿⣻⣽⣿⣿⣽⣾⣿⣿⣻⣽⣾⡇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠉⢱⠎⠰⣉⠲⣁⠚⣸⣿⣿⣿⣿⣿⠟⠠⠐⢸⣿⣯⣿⢿⣷⣿⡿⣿⣻⣷⣿⣿⡿⠗⠋⡁⢸⣿⣽⡿⣟⣿⡇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢨⢳⠀⡈⠙⠒⠭⣸⣿⠿⠛⢁⠰⡀⢆⠉⢼⣿⣟⣿⣿⣻⣷⣿⣿⢿⣿⣿⠁⠀⡐⠠⠐⢸⣿⣿⢿⣿⡿⣇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠐⣏⠐⠠⠁⠌⡐⣿⣿⣶⣮⡄⣣⠑⢤⣉⢺⣿⣿⣿⣿⡿⣿⣽⣾⣿⡿⣿⠠⢁⠠⢡⠈⢸⣿⣿⣿⣯⣿⡇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢘⡒⠠⠄⡉⠐⡀⣿⣿⡿⣿⡇⠀⠙⠓⢤⣺⣿⣿⣾⢿⣽⡿⣿⣿⣿⣿⣿⠐⠠⢁⠂⢌⢸⣿⣿⣾⣿⣽⡇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠠⢇⡁⢂⠡⠡⠐⣿⣿⣿⢿⡇⠈⡐⠈⠄⠠⢸⣿⡿⣿⣻⣿⣿⣿⣿⣻⣿⠀⡑⠂⠌⡐⢸⣿⣿⣷⡿⣿⡇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠘⣆⠐⠢⢀⠱⢈⣿⣿⡿⣿⡇⡐⠠⠡⠈⠄⢻⣿⣿⢿⣿⣷⣿⣿⣿⣿⣿⠠⢌⡑⠠⡐⢸⣿⣿⣯⣿⣿⡇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠘⣶⠈⢡⠂⡐⠠⣿⣿⣿⣿⡇⠤⢁⠢⢁⠌⣸⣿⣿⣿⣻⣾⣿⣿⣿⣿⣿⠐⠢⢌⠑⠤⢹⣿⣿⣿⣟⣿⡇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠘⡦⢘⢢⠐⣈⠡⣿⣿⣿⣾⡇⠒⠠⢈⠂⡐⢼⣿⣿⣾⢿⣟⡿⠟⠚⠁⢸⢊⠡⢌⠚⡠⢺⣿⣿⣿⣿⣿⡇⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢘⡵⢈⢂⡱⣀⠒⣿⣿⣿⣿⡇⠈⡅⢂⠂⠡⢺⣿⣿⣽⣿⣿⡇⠀⠀⠀⢸⠇⣘⠢⣡⠑⣼⣿⣿⣿⣿⣿⢧⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢸⣹⠀⢇⠰⣀⠎⣿⣿⣿⣿⡇⢰⠈⠆⡈⠁⣾⣿⣿⣿⣹⣿⡇⠀⠀⠀⠀⠈⠷⢶⡀⢇⢸⣿⣿⢿⠷⠏⠁⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠘⢮⡘⡄⠓⣄⢊⣿⣿⣿⣿⡇⢂⢍⡒⢠⠑⣸⣿⣿⣿⢿⣻⡇⠀⠀⠀⠀⠀⠀⠀⠈⠓⠸⠛⠉⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⠤⣊⣿⡿⠟⠉⡇⡌⢄⠒⢢⠁⢾⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⡗⠣⢌⡸⠡⠜⣸⣿⣿⣿⣿⣽⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⠦⣐⠣⠌⣽⣿⣿⣿⠯⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠚⠼⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
```

## 👷‍♂️Requirements
The following are either required to run this or are hearty suggestions.

- [kubectl] configured for kubernetes debugging and deployment
- [tilt] for development
- [just] for common commands
- internally used within commands
  - [helm]
  - [jq]
  - [curl]
  - [awk]
  - [sed]
- ⚠️This project requires existing environment variables (see `.env.sample`)

NOTE: many of these can be installed with either [brew] or [asdf]

## Setup

check out the available commands or just view `justfile` contents

```commandline
just --list
```

# Minecraft Server Commands (available on all servers that use Hoox Plugin)
## Reset

- `/save`: saves current world state remotely using `utils` container (so that cluster failure doesn't lose data)
- 


[just]: https://github.com/casey/just
[asdf]: https://asdf-vm.com/
[kubectl]: https://kubernetes.io/docs/reference/kubectl/
[brew]: https://brew.sh/
[jq]: https://jqlang.org
[helm]: https://helm.sh
[curl]: https://curl.se
[awk]: https://www.gnu.org/software/gawk/manual/gawk.html
[sed]: https://www.gnu.org/software/sed/manual/sed.html
[IBM's work]: https://www.ibm.com/developerworks/cloud/library/cl-bluemix-minecraft-docker-trs-1/index.html
[tilt]: https://tilt.dev
