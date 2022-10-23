FROM nginx:latest

ARG TARGETARCH

# RUN \
#     apt update && \
#     apt upgrade -y && \
#     apt install -y --no-install-recommends

COPY installer.sh /installer.sh
RUN chmod +x /installer.sh
# RUN ls -la .
RUN /installer.sh

COPY nginx.conf /etc/nginx/nginx.conf


COPY docker-entrypoint.d/ /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.d/999-ngssc.sh
RUN chmod +x /docker-entrypoint.d/01-backend.sh

# Cleanup
# RUN rm /dependency-installer.sh
# RUN rm java.tar.gz

ENV AM_I_IN_A_DOCKER_CONTAINER True

EXPOSE 8080
EXPOSE 80
