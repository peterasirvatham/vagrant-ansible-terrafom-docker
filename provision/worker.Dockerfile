FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      openssh-server python3 sudo && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd /root/.ssh && \
    chmod 700 /root/.ssh && \
    printf '\nPermitRootLogin prohibit-password\n' >> /etc/ssh/sshd_config

EXPOSE 22

CMD ["/bin/bash", "-lc", "ssh-keygen -A && exec /usr/sbin/sshd -D -e"]
