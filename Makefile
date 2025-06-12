.PHONY:build
build:
	@nix-build ./nix

.PHONY:clean
clean:
	@rm -rf result*

.PHONY:run
run:
	@result/bin/hello-exe
