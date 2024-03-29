FROM mongo:4.4.26

COPY ./rootfs /

RUN apt update && apt upgrade -y && \
# alter default entrypoint
    sed -i '/unset "${!MONGO_INITDB_@}"/d' /usr/local/bin/docker-entrypoint.sh && \
    sed -i '/exec "$@"/d' /usr/local/bin/docker-entrypoint.sh && \
    grep -v /usr/bin/env /usr/local/bin/custom-entrypoint >> /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mongod"]