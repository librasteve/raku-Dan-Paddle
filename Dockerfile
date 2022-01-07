FROM p6steve/rakudo:ubuntu-arm64-2021.05
      
ENV PATH=$PATH:/usr/share/perl6/site/bin

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y git curl

RUN git clone git://github.com/jmmills/docker-plenv-base.git ~/.plenv/base
RUN git clone git://github.com/tokuhirom/plenv.git /usr/share/plenv
RUN git clone git://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build
ENV PATH = $PATH:/usr/share/plenv/bin

RUN cp ~/.plenv/base/plenv_profile.sh /etc/profile.d/plenv.sh
RUN cp ~/.plenv/base/plenv-latest_version /usr/share/plenv/libexec/

RUN echo 'export PATH="$HOME/.plenv/bin:$PATH"' >> ~/.profile
RUN echo 'eval "$(plenv init -)"' >> ~/.profile 
RUN plenv install-cpanm

ONBUILD RUN plenv rehash

CMD ["/bin/bash", "-l"]
