FROM ruby
MAINTAINER "Ruby Geckodriver"

#Instalar o browser Firefox
RUN mkdir /opt/firefox
RUN apt-get update -qqy
RUN wget -O /tmp/firefox.tar.bz2 "https://download-installer.cdn.mozilla.net/pub/firefox/releases/65.0/linux-x86_64/en-US/firefox-65.0.tar.bz2"
RUN tar -C /opt -xjf /tmp/firefox.tar.bz2
RUN ln -s /opt/firefox/firefox /usr/bin/firefox
RUN apt-get -qqy install libgtk-3-dev
RUN apt-get install libdbus-glib-1-2

# Instalar o driver do Firefox (Geckodriver)
RUN gem install geckodriver-helper -v 0.23.0 && gecko_updater

#Instalação do Python
RUN apt update
RUN apt install -y software-properties-common
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt install python3.7
RUN apt install -y python3-pip
# Criar pasta para copiar o projeto para dentro do container
RUN mkdir miles
COPY . /miles
WORKDIR /miles

#Instalar lib de gerenciamento da gems
RUN gem install bundler
RUN bundle

#Dependencia Python
RUN pip3 install -r requirements.txt

#Executar a automação
CMD ["ruby", "run.rb"]
