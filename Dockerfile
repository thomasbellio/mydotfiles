FROM ubuntu

# Install necessary packages
RUN apt update -y && \
    apt install -y git ssh openssh-client && \
    mkdir -p ${HOME}/code && \
    mkdir -p /root/.ssh

# Set up git configuration
WORKDIR /app
RUN git config --global --add safe.directory /app && \
    git config --global user.email "thomas@thomasbell.io" && \
    git config --global user.name "Thomas Bell"

# Configure SSH to avoid host key verification issues
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config && \
    chmod 600 /root/.ssh/config

# Copy the entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Default command (can be overridden)
CMD ["sleep", "infinity"]