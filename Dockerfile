FROM ubuntu

# Install necessary packages
RUN apt update -y && \
    apt install -y git ssh openssh-client curl zsh && \
    chsh -s $(which zsh) && \
    mkdir -p /root/.ssh && \
    mkdir -p /root/code/ && \
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
    rm -rf /opt/nvim && \
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz
ENV PATH="$PATH:/opt/nvim-linux-x86_64/bin"
# Configure SSH to avoid host key verification issues
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config && \
    chmod 600 /root/.ssh/config

WORKDIR /root/code/

RUN git config --global user.email "thomas@thomasbell.io" && \
    git config --global user.name "Thomas Bell" && \
    git clone -b version-2 https://github.com/thomasbellio/mydotfiles.git && \
    ln -s /root/code/mydotfiles/zsh/zshfeatures /root/.zshfeatures && \
    ln -s /root/code/mydotfiles/zsh/zshconfig-v2 /root/.zshrc
# Set up git configuration
WORKDIR /root


# ADD ./zsh/zshfeatures /root/.zshfeatures
# ADD ./zsh/zshconfig-v2 /root/.zshrc

# Default command (can be overridden)
CMD ["sleep", "infinity"]
