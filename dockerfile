# Use the official Debian image as a base
FROM debian:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install required dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    docker.io \
    docker-compose \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /opt

# Clone Mailcow repository
RUN git clone https://github.com/mailcow/mailcow-dockerized.git

# Change directory to mailcow
WORKDIR /opt/mailcow-dockerized

# Copy configuration file (if available)
COPY mailcow.conf ./mailcow.conf

# Expose necessary ports
EXPOSE 25 80 110 143 443 465 587 993 995 4190

# Start Mailcow services
CMD ["./generate_config.sh", "&&", "docker-compose", "up", "-d"]
