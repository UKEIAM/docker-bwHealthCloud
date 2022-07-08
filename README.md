# Docker files to build images for bwHealthCloud Frontend and Backend

The purpose of this project is to provide docker images for [bwHealthCloud](https://www.telemedbw.de/projekte/bwhealthcloud).

## First steps

Make sure that latest release files are in the project directory, as docker build will pick them up without downloading them.

## Build images

This project contains two files for use with frontend and backend `Frontend.Dockerfile` and `Backend.Dockerfile`.
Both of them use build arguments to customize build on build time.

### Frontend

To build the image for bwHealthCloud frontend, use the following command

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

### Backend

To build the image for bwHealthCloud backend, use the following command

```
docker build -t bwhc-backend -f Backend.Dockerfile .
```

This will create the image with the default build arguments and mark it as `bwhc-backend`. To customize the build, specify custom values.

* `VERSION`: The version to be used. Current value `2205`
* `BWHC_BASE_DIR`: The directory to hold the application and config files. Defaults to `/bwhc-backend`.

e.g.:

```
docker build -t bwhc-backend -f Backend.Dockerfile --build-arg BWHC_BASE_DIR=/opt/bwhc-backend .
```

## Run the images

Both images can be started like any other docker image. Make sure you provide required docker volumes to keep data after service recreation.

The backend image uses two volumes relative to `$BWHC_BASE_DIR` provided at build time: `$BWHC_BASE_DIR/data` and `$BWHC_BASE_DIR/hgnc_data`.

To use custom logging configuration in `logback.xml` and/or custom `bwhcConnectorConfig.xml` for backend,
mount these files as readonly volumes or docker configuration to `$BWHC_BASE_DIR/logback.xml`
and `$BWHC_BASE_DIR/bwhcConnectorConfig.xml`.

## Using Docker Compose

This project provides support for Docker Compose. So it is possible to build and run frontend and backend using Docker compose.

## Limitations and final notes

The image for bwHealthCloud Frontend starts as expected, using configured build arguments and environment variables at build time.
Since frontends access to the backend is configured at build time, it is not required to provide environment variables at runtime.

The bwHealthCloud Backend image starts using start command provided in release package.
I have not tested if there are any issues running the backend in addition to login.
