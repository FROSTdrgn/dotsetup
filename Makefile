# -Syu = install latest package(s) and upgrade dependencies to latest
pacman := sudo pacman -S --needed
paru := paru -Syu --needed
pnpm := pnpm i -g
code-ext := code --install-extension

## Special Env Variables
PNPM_HOME := $(HOME)/Library/pnpm

defaultJob:
	echo "No default job. Run install to install everything."

install: status/core status/apps status/vscode-extensions status/fish status/nodejs-global

upgrade:
	$(pacman) -yu

status/init:
	$(pacman) yq
	touch status/init

status/core: status/init packages/core.yaml
	$(pacman) $(shell yq -r .main[] packages/core.yaml)
	$(paru)   $(shell yq -r .aur[]  packages/core.yaml)
	git credential-oauth configure
	echo "source $(HOME)/.setup/config/fish/main.fish" > $(HOME)/.config/fish/conf.d/$(USER).fish
	touch status/core

status/apps: status/core packages/apps.yaml
	$(pacman) $(shell yq -r .main[] packages/apps.yaml)
	$(paru)   $(shell yq -r .aur[]  packages/apps.yaml)
	touch status/apps

status/nodejs-global: status/core packages/nodejs-global.yaml
	mkdir -p $(PNPM_HOME)/bin
	export PATH="$(PNPM_HOME)/bin:$(PATH)"
	pnpm config set -g global-dir "$(PNPM_HOME)"
	pnpm config set -g global-bin-dir "$(PNPM_HOME)/bin"
	$(pnpm)   $(shell yq -r .main[] packages/nodejs-global.yaml)
	touch status/nodejs-global

status/vscode-extensions: status/core packages/vscode-extensions.yaml
	for EXT in $(shell yq -r .main[] packages/vscode-extensions.yaml); do $(code-ext) $$EXT; done
	touch status/vscode-extensions

status/fish: status/core install/fish-tide-theme
	install/fish-tide-theme
	touch status/fish

link-config-paths:
	rm -rf $(HOME)/.setup/ghostty
	ln -s $(HOME)/.setup/config/ghostty $(HOME)/.config/ghostty
	rm -rf $(HOME)/.setup/Code/User/settings.json
	ln -s $(HOME)/.setup/config/vscode/User/settings.json $(HOME)/.config/Code/User/settings.json
