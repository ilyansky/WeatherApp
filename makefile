all: push

develop:
	git checkout -b develop

push:
	git add -A
	@echo "Enter commit message: " && read msg; \
	git commit -m "$$msg"
	git push
	awk 'BEGIN{srand(); printf "+ %dXP\n", int(100+rand()*21)}'

cleanbrew:
	brew doctor
	brew autoremove
	brew cleanup

