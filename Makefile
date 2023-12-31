# -----------------------------------------------------------------------------
# constants
# -----------------------------------------------------------------------------

BASE_OS := ubuntu
BASE_OS_VERSION := 22.04

IMAGE_FILE := Containerfile
IMAGE_NAME := schuam/crosstool-ng

CTNG_VERSION := 1.26.0

IBT := podman    # IBT stands for "image build tool"
GIT := git


# -----------------------------------------------------------------------------
# targets
# -----------------------------------------------------------------------------

.PHONY: help

# The idea of the help target is to print out a 'help' for the user that lists
# all targets and explains them. Each target that is supposed to be listed in
# the help must be commented like this:
# 
# ## <TARGET NAME>: This is a description of the target. In case the
# ## description is to long for one line, it can be split like this.
# <TARGET NAME>: dependencies
# [TAB]recipe

## help: Show this help
help: Makefile
	@echo ""
	@echo "The following targets exist:"
	@sed -n -e '/^## \S/ s/^## //p' -e 's/^## \s\+/: /p' $< | \
		awk -F ": " '{printf "\033[33m%-20s\033[0m%s\n", $$1, $$2};'
	@echo ""


## image: Build the podman image
image:
	$(IBT) build \
		-f $(IMAGE_FILE) \
		-t $(IMAGE_NAME):latest \
		-t $(IMAGE_NAME):$(BASE_OS)-latest \
		-t $(IMAGE_NAME):$(CTNG_VERSION) \
		-t $(IMAGE_NAME):$(CTNG_VERSION)-$(BASE_OS)-$(BASE_OS_VERSION) \
		-t $(IMAGE_NAME):`$(GIT) describe --tags --dirty --always` \
		--build-arg BASE_OS=$(BASE_OS) \
		--build-arg BASE_OS_VERSION=$(BASE_OS_VERSION) \
		--build-arg CTNG_VERSION=$(CTNG_VERSION) \
		.

