.DEFAULT_GOAL := all
.PHONY: all fmt build-nixos

NIX_CMD  ?= nix --experimental-features 'nix-command flakes'
HOSTNAME ?= nixos

all: fmt

fmt:
	(nix fmt)
	(prettier -w .)

build-nixos:
	(${NIX_CMD} build '.#nixosConfigurations.${HOSTNAME}.config.system.build.toplevel')

build-installer:
	(${NIX_CMD} build '.#installer')
