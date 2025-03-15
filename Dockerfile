FROM ubuntu

# Create devel user with sudo privileges and matching host UID/GID
# We use ARGs to pass in the host's user ID and group ID at build time
ARG USER_UID=1000
ARG USER_GID=1000


RUN yes | unminimize
# Install necessary packages
RUN apt update -y && \
    apt install -y man-db && \
    apt install -y git ssh openssh-client curl zsh sudo && \
    chsh -s $(which zsh) && \
    mkdir -p /root/.ssh && \
    mkdir -p /root/code/ && \
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
    rm -rf /opt/nvim && \
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# Check if the group already exists and handle accordingly
RUN if getent group $USER_GID > /dev/null 2>&1; then \
        # If group with GID exists, use it
        existing_group=$(getent group $USER_GID | cut -d: -f1) && \
        echo "Using existing group $existing_group with GID $USER_GID" && \
        useradd -m -u $USER_UID -g $USER_GID -s $(which zsh) devel; \
    else \
        # Create new group and user
        groupadd -g $USER_GID devel && \
        useradd -m -u $USER_UID -g $USER_GID -s $(which zsh) devel; \
    fi && \
    # Setup sudo access
    echo "devel ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devel && \
    chmod 0440 /etc/sudoers.d/devel && \
    # Allow sudo to run commands as any user without requiring a password
    echo "devel ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.d/devel

ENV PATH="$PATH:/opt/nvim-linux-x86_64/bin"
# Configure SSH to avoid host key verification issues
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config && \
    chmod 600 /root/.ssh/config

# Set up home directory for devel user
RUN mkdir -p /home/devel/code && \
    mkdir -p /home/devel/.ssh && \
    chown -R devel:devel /home/devel

# Copy over git configuration files
WORKDIR /home/devel/code/

# Add the zsh configuration
ADD ./zsh/zshconfig-v2 /home/devel/.zshrc

# Set up git configuration for devel user
RUN git config --global --add safe.directory '*' && \
    git clone https://github.com/thomasbellio/mydotfiles.git && \
    rm /home/devel/.zshrc && \
    ln -s /home/devel/code/zsh/zshfeatures /home/devel/.zshfeatures && \
    ln -s /home/devel/code/zsh/zshconfig-v2 /home/devel/.zshrc && \
    chown -R devel:devel /home/devel/

# Switch to devel user for subsequent operations
USER devel

# Set working directory
WORKDIR /home/devel

# ADD ./zsh/zshconfig-v2 /root/.zshrc
#
# RUN git config --global --add safe.directory '*' && \
#     git clone https://github.com/thomasbellio/mydotfiles.git && \
#     rm /root/.zshrc && \
#     ln -s /root/code/mydotfiles/zsh/zshfeatures /root/.zshfeatures && \
#     ln -s /root/code/mydotfiles/zsh/zshconfig-v2 /root/.zshrc
# # Set up git configuration
# WORKDIR /root
#
#

# Default command (can be overridden)
CMD ["sleep", "infinity"]
