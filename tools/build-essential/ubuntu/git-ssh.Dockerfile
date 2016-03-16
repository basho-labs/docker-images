RUN \
  git config --global url."ssh://git@github.com/".insteadOf https://github.com/ && \
  echo "StrictHostKeyChecking no" >>/etc/ssh/ssh_config
