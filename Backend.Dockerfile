FROM openjdk:11-jre

# Change to latest release
ARG VERSION=2205

ARG BWHC_BASE_DIR=/bwhc-backend

ENV BWHC_BASE_DIR=$BWHC_BASE_DIR
ENV BWHC_USER_DB_DIR=$BWHC_BASE_DIR/data/user-db
ENV BWHC_DATA_ENTRY_DIR=$BWHC_BASE_DIR/data/data-entry
ENV BWHC_QUERY_DATA_DIR=$BWHC_BASE_DIR/data/query-data

COPY bwhc-backend_$VERSION.zip /
RUN unzip bwhc-backend_$VERSION.zip && rm bwhc-backend_$VERSION.zip

WORKDIR $BWHC_BASE_DIR

# Prepare config file to use environment variables from docker
RUN sed -i -r "s/APPLICATION_SECRET(.*)/#APPLICATION_SECRET\1/" ./config
RUN sed -i -r "s/ZPM_SITE(.*)/#ZPM_SITE\1/" ./config

# Prepare config file to use fix environment variables for this image
RUN sed -i -r "s~BWHC_DATA_ENTRY_DIR.*~BWHC_DATA_ENTRY_DIR=$BWHC_DATA_ENTRY_DIR~" ./config
RUN sed -i -r "s~BWHC_QUERY_DATA_DIR.*~BWHC_QUERY_DATA_DIR=$BWHC_QUERY_DATA_DIR~" ./config
RUN sed -i -r "s~BWHC_USER_DB_DIR.*~BWHC_USER_DB_DIR=$BWHC_USER_DB_DIR~" ./config

RUN ./install.sh $BWHC_BASE_DIR

VOLUME $BWHC_BASE_DIR/data
VOLUME $BWHC_BASE_DIR/hgnc_data

EXPOSE 9000

CMD $BWHC_BASE_DIR/bwhc-backend-service start
