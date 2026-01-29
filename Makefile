clean:
	nix-collect-garbage -d
	sudo nix-collect-garbage -d
	nix-store --optimise # NOTE: this command takes a while

update:
	sudo nix flake update
	sudo darwin-rebuild switch
