FROM archlinux:latest
ENV ANSIBLE_HOST_KEY_CHECKING False
RUN pacman -Sy --noconfirm ansible openssh findutils
RUN ansible-galaxy collection install community.general
RUN mkdir /root/ansible
RUN mkdir -p /root/.ssh && ln -s /run/secrets/user_ssh_key /root/.ssh/id_rsa
RUN echo "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
COPY id_rsa_shared /root/.ssh/id_rsa.pub
RUN chown root:root /root/.ssh
WORKDIR /root/ansible
ADD . .
RUN sh keyscan.sh
CMD ["/bin/bash"]
