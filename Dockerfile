FROM udacity/carnd-term1-starter-kit

# Pick up some TF dependencies (as a first step, add missed repos)
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
&&  apt-get update && apt-get install -y --no-install-recommends \
        ffmpeg \
&&  apt-get clean \ 
&&  rm --recursive --force /var/lib/apt/lists/*

