.DEFAULT_GOAL := all
.PHONY: all fmt build-nixos build-installer gen

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

gen:
	(mkdir -p gen/ && ./scripts/vsc-ext.sh > gen/vsc.nix)
