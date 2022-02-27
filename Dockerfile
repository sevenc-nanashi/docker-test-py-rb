FROM debian:buster-slim
RUN apt-get update
RUN apt-get install git build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev wget libbz2-dev nginx -y
WORKDIR /root
SHELL [ "/bin/bash", "-l", "-c" ]

# -- Languages -----------------------------------
## -- Python -------------------------------------
RUN wget https://www.python.org/ftp/python/3.9.10/Python-3.9.10.tgz; \
    tar xzf Python-3.9.10.tgz; \
    cd Python-3.9.10; \
    ./configure --enable-optimizations; \
    make -j4; \
    make altinstall

### -- pip ---------------------------------------
RUN wget https://bootstrap.pypa.io/get-pip.py; \
    python3.9 get-pip.py

## -- Ruby ---------------------------------------
WORKDIR /root
RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv; \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /root/.bashrc; \
    echo 'eval "$(rbenv init -)"' >> /root/.bashrc ; \
    git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build; \
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /root/.bashrc; \
    source /root/.bashrc; \
    rbenv install 3.1.1; \
    rbenv global 3.1.1
### -- bundler -----------------------------------
RUN gem install bundler

# -- Files ---------------------------------------
ADD . /root

# -- Installations --------------------------------
RUN pip install -r requirements.txt; \
    bundle install

## -- nginx ---------------------------------------
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD ["/bin/bash", "-l", "/root/main.sh"]