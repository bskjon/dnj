FROM nginx:latest

ARG TARGETARCH


COPY dep /dep

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

RUN rm -r /dep

EXPOSE 8080
EXPOSE 80
