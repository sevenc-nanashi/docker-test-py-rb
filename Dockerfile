FROM ubuntu:20.04
ENV TZ=Asia/Tokyo

# -- Basic ---------------------------------------
RUN apt-get update; \
    apt-get install -y \
    tzdata; \
    apt-get install -y \
    git software-properties-common
WORKDIR /root
SHELL [ "/bin/bash", "-l", "-c" ]

# -- Languages -----------------------------------
## -- Python -------------------------------------
RUN add-apt-repository ppa:deadsnakes/ppa; \
    apt-get install -y python3.9 python3.9-dev python3.9-venv

## -- Ruby ---------------------------------------
### -- Install ruby-build ------------------------
WORKDIR /root
RUN git clone https://github.com/rbenv/ruby-build.git /root/ruby-build; \
    cd /root/ruby-build; \
    ./install.sh

### -- Build -------------------------------------
RUN apt-get install -y curl build-essential libssl-dev zlib1g-dev; \
    ruby-build 3.1.1 /usr/local/bin/ruby -v

### -- Setup -------------------------------------
RUN echo "export PATH=/usr/local/bin/ruby/bin:$PATH" >> /etc/profile.d/ruby.sh

### -- bundler -----------------------------------
RUN gem install bundler

# -- Files ---------------------------------------
ADD . /root

# -- Installations --------------------------------
RUN pip install -r requirements.txt; \
    bundle install

## -- nginx ---------------------------------------
RUN apt-get install -y nginx
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD ["/bin/bash", "-l", "/root/main.sh"]