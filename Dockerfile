FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    libglu1-mesa \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

ENV FLUTTER_HOME=/flutter
ENV PATH=$PATH:$FLUTTER_HOME/bin

RUN git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME
RUN flutter doctor

RUN flutter config --enable-web

RUN npm install -g http-server

WORKDIR /app

COPY pubspec.yaml .
RUN flutter pub get

COPY . .

RUN flutter build web --release

EXPOSE 8080

CMD ["http-server", "build/web", "-p", "8080"]
