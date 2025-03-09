FROM ubuntu

# Install necessary packages
RUN yes | unminimize && \
    apt update -y && \
    apt install -y man-db && \
    apt install -y npm && \
    apt install -y git ssh openssh-client curl zsh && \
    npm install --global pure-prompt && \
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

ADD ./zsh/zshconfig-v2 /root/.zshrc

RUN git config --global --add safe.directory '*' && \
    git clone -b version-2 https://github.com/thomasbellio/mydotfiles.git && \
    rm /root/.zshrc && \
    ln -s /root/code/mydotfiles/zsh/zshfeatures /root/.zshfeatures && \
    ln -s /root/code/mydotfiles/zsh/zshconfig-v2 /root/.zshrc
# Set up git configuration
WORKDIR /root



# Default command (can be overridden)
CMD ["sleep", "infinity"]
