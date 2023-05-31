# Swanky dev container

## Intro

Dev container is a Visual Studio Code extension that allows for sharing a full dev environment.

This means you can develop your project inside a preconfigured container with all prerequisites met and correct dependencies installed. This includes Rust compiler, `cargo contract` and `swanky-cli`.

## Prerequisites

To run the container, you will need:

- Visual Studio Code with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) enabled
- Docker engine installed and the daemon running

More detailed information on system requirements can be [found here](https://code.visualstudio.com/docs/devcontainers/containers#_system-requirements).

## Software versions

Swanky dev container comes with `cargo contract` v2 and `swanky-cli` v3 installed, supporting and optimized for ink! v4 and above. If you need an older version, please refer to the [environmet setup docs](https://docs.astar.network/docs/build/environment/ink_environment#ink-cli) and [`swanky-cli` update guide](#updating-swanky-version)

## Usage

- This is a template repo, create a new repo from this template, or clone it
- open the repo in VS Code

There should be a popup in the lower-right offering you to open the container. Click "Reopen in Container".

<p align="center">
<img src="https://github.com/AstarNetwork/swanky-dev-container/blob/main/images/popup.png" width=300/>
</p>

You can also click on the green button on the lower-left to open the dev container commands menu, and select "Reopen in container" from there.

<p align="center">
<img src="https://github.com/AstarNetwork/swanky-dev-container/blob/main/images/button.png" width=300/>
</p>
<p align="center">
<img src="https://github.com/AstarNetwork/swanky-dev-container/blob/main/images/menu.png" width=300/>
</p>

### Terminal

To interact with your project (including calling `swanky` commands), use VS Code integrated terminal.

## Updating swanky version

Swanky is installed into `/opt/swanky`, and the main executable is linked to `/usr/local/bin/swanky`.

To update the Swanky version you can use the following steps:

```bash
sudo rm -rf /opt/swanky /usr/local/bin/swanky
wget -O /tmp/swanky.tar.gz [new_version_url]
sudo tar -xf /tmp/swanky.tar.gz -C /opt
sudo ln -s /opt/swanky/bin/swanky /usr/local/bin/swanky
```

### Adding vscode extensions

Any VS code extensions you need to run during the development in the container need to be specified in the `devcontainer.json` file.

To add the extensions you want, copy the identifier found in the extension details page into the `customizations.vscode.extensions` array in `devcontainer.json`

### Add features

Features are "modules" that can be added to the dev container to install additional software or extend the functionality.

Officially supported and community maintained features can be [found here](https://containers.dev/features), but you can also build your own.

To add a feature, simply copy it's reference into the `features` field.

> Note: not all features are compatible, and some need to be installed in a specific order. Check the readme before adding any.

## References

- [Dev containers manual](https://code.visualstudio.com/docs/devcontainers/containers)
- [Dev container specification](https://containers.dev/)
- [swanky-cli](https://github.com/AstarNetwork/swanky-cli)
