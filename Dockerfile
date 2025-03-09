FROM ubuntu

RUN apt update -y && \
    apt install -y git && \
    apt install -y ssh && \
    mkdir ${HOME}/code
WORKDIR /app
RUN git config --global --add safe.directory /app && \
        git config --global user.email "thomas@thomasbell.io" && \
        git config --global user.name "Thomas Bell"
CMD ["sleep", "infinity"]
