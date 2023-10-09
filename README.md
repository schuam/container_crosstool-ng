# Container for crosstool-ng

I wanted to have a (Podman) container that I can use to build toolchains for
embedded linux projects. These toolchanis can be build with the tool
crosstool-ng. At least for now, I will use Ubuntu to develop embedded linux
projects, that's why the container should be based on an Ubuntu image. I might
extend that to other distros later (e.g. alpine).

This repo contains a Containerfile to build a (Podman) container image and a
Makefile to facilitate the container build process.


## Usage

To build a toolchain for an embedded linux project, go into the project
directory and run the following command to start the container (make sure to
use the desired tag (e.g. `latest` as in the example):

```bash
podman run -it --rm -v .:/data schuam/crosstool-ng:latest
```

In the container, you can use the `ct-ng` command to configure and build your
toolchains. A built toolchain can be found in the sub-drirectory `x-tool` of
your project directory.

