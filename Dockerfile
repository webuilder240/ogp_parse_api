FROM ruby:2.7.2

ENV LANG C.UTF-8
ENV RACK_ENV production
EXPOSE 3000

# aptで日本のミラーを使う
RUN echo "deb http://ftp.jp.debian.org/debian jessie main non-free contrib" > /etc/apt/sources.list && \
  echo "deb-src http://ftp.jp.debian.org/debian jessie main non-free contrib" && \
  echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list && \
  echo "deb-src http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list && \
  echo "deb http://ftp.jp.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list && \
  echo "deb-src http://ftp.jp.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && echo "Asia/Tokyo" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install -j4 --without development test

RUN mkdir tmp
COPY . /usr/src/app
CMD bundle exec puma -C config/puma.rb
