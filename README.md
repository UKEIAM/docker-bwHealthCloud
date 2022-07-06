# Docker files to build images for bwHealthCloud Frontend and Backend

The purpose of this project is to provide docker images for [bwHealthCloud](https://www.telemedbw.de/projekte/bwhealthcloud).

## First steps

Make sure that latest release files are in the project directory, as docker build will pick them up without downloading them.

## Frontend

To build the image for bwHealtCloud frontend, use the following command

```
docker build -t bwhc-frontend -f Frontend.Dockerfile .
```

This will create the image using default build arguments and mark it as `bwhc-frontend`. To customize the build, spezify custom values.

* `VERSION`: The version to be used. Current value `2205`
* `NUXT_HOST` and `NUXT_PORT`: Server configuration, see 2.3 of bwHC manual for more information.
* `BACKEND_PROTOCOL`, `BACKEND_HOSTNAME` and `BACKEND_PORT`: Backend access, see 2.4 of bwHC manual for more information.

e.g.:

```
docker build -t bwhc-frontend -f Frontend.Dockerfile --build-arg NUXT_PORT=1234 .
```

## Backend

To build the image for bwHealtCloud backend, use the following command

```
docker build -t bwhc-backend -f Backend.Dockerfile .
```

This will create the image with the default build arguments and mark it as `bwhc-backend`. To customize the build, specify custom values as shown above.

* `VERSION`: The version to be used. Current value `2205`
* `BWHC_BASE_DIR`: The directory to hold the application and config files

e.g.:

```
docker build -t bwhc-frontend -f Frontend.Dockerfile --build-arg NUXT_PORT=1234 .
```

## Using Docker Compose

This project provides support for Docker Compose. So it is possible to build and run frontend and backend using Docker compose.
