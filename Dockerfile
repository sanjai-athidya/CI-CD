# Base image
FROM ubuntu:20.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install Apache & required tools
RUN apt-get update && \
    apt-get install -y apache2 git curl && \
    apt-get clean

# Set working directory to Apache's web root
WORKDIR /var/www/html

# Expose port 82 (as required)
EXPOSE 82

# Change Apache to listen on port 82 instead of 80
RUN sed -i 's/80/82/g' /etc/apache2/ports.conf && \
    sed -i 's/80/82/g' /etc/apache2/sites-enabled/000-default.conf

# Start Apache when container runs
CMD ["apachectl", "-D", "FOREGROUND"]
