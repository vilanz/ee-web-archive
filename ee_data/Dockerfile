FROM python:3

COPY . ee_data

WORKDIR /ee_data

RUN ./setup.sh

# We need to let the user "nobody" (used in the main container) access this data
# setfacl is awkward with Docker, so we're just using the brute chown instead
RUN chown -R nobody /var/lib/ee-web-archive
