FROM nginx:latest

ARG TARGETARCH
ENV AM_I_IN_A_DOCKER_CONTAINER True


COPY dependency-installer.sh /dependency-installer.sh
RUN chmod +x /dependency-installer.sh
RUN /dependency-installer.sh

COPY nginx.conf /etc/nginx/nginx.conf


COPY docker-entrypoint.d/ /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.d/999-ngssc.sh
RUN chmod +x /docker-entrypoint.d/01-backend.sh

# Cleanup
RUN rm /dependency-installer.sh
RUN rm java.tar.gz

EXPOSE 8080
EXPOSE 80
