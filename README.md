# Introduction to Docker Containers
(work in progress)
Introduction presentation about containers, for use in the docker-introduction workshop

## Build
Have `pandoc` installed (tested with version 2.17) and run `make`.

## Watch (Linux only)
If you're on Linux, you can run `make watch` to rerun Pandoc on every change. This also starts a `browser-sync` server. You need:

- `nodejs` & `npm`
- `browser-sync` (`npm install -g browser-sync`)
- `inotifywait` (`sudo dnf install inotify-tools` or `sudo apt install inotify-tools`)

## License
CC-BY 4.0 Netherlands eScience Center
Parts of this presentation were inspired on the actual lesson content of the [Carpentries Incubator](https://carpentries-incubator.github.io/docker-introduction/).
