FROM nginx:latest


# Wont need these..
# RUN \
#     apt update && \
#     apt upgrade -y && \
#     apt install -y --no-install-recommends


COPY dependency-installer.sh /dependency-installer.sh
RUN chmod +x /dependency-installer.sh
RUN /dependency-installer.sh

COPY nginx.conf /etc/nginx/nginx.conf


COPY docker-entrypoint.d/ /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.d/999-ngssc.sh
RUN chmod +x /docker-entrypoint.d/01-backend.sh

# Cleanup
RUN rm /dependency-installer.sh

EXPOSE 8080
EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]
# ENTRYPOINT [ "/entrypoint.sh" ]