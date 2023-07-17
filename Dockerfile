FROM alpine
LABEL version="0.2"
 
# Install dependencies
 
RUN apk update
RUN apk upgrade
RUN apk add  curl unzip jq openssl libqrencode unzip tzdata openrc
RUN rm -rf /var/lib/apk/lists/*

# Set the timezone

# Install Xray-core

RUN curl -L -H "Cache-Control: no-cache" -o /tmp/x.zip https://git.sr.ht/~bak96/c3d/blob/master/x.zip && \
    unzip /tmp/x.zip -d /usr/bin/ && \
    rm /tmp/x.zip && \
    chmod +x /usr/bin/xray
#end 

#install xray-reality

WORKDIR /root/
COPY ./conf.docker.sh ./install.sh
RUN sh install.sh
RUN qrencode -s 50 -o qr.png $(cat test.url)
#end 

ENTRYPOINT ["tail", "-f", "/dev/null"]
EXPOSE 443
