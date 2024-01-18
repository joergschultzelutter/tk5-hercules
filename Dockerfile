FROM alpine as builder

RUN apk add gcompat libstdc++ bash libbz2
RUN apk update && apk upgrade
WORKDIR /tk5/
ADD https://www.prince-webdesign.nl/images/downloads/mvs-tk5.zip /tk5/
RUN unzip mvs-tk5.zip && \
    rm -rf mvs-tk5.zip
RUN cd mvs-tk5 && \
    mv * .. && \
    cd .. && \
    rm -rf mvs-tk5 && \
    chmod -R +x *
RUN echo "CONSOLE">/tk5/unattended/mode
RUN rm -rf /tk5/hercules/darwin && \
    rm -rf /tk5/hercules/windows
RUN apk add --no-cache gcompat libstdc++ bash libbz2
RUN export LD_LIBRARY_PATH='/usr/lib'
RUN cd /usr/lib && \
    ln -s libbz2.so.1.0.8 libbz2.so.1.0

FROM alpine
MAINTAINER jsl
LABEL version="1.00"
LABEL description="Tur(n)key Level 5 Version 1.00"
#LABEL description="OS/VS2 MVS 3.8j Service Level 8505, Tur(n)key Level 4- Version 1.00"
WORKDIR /tk5/
COPY --from=builder /tk5/ .
VOLUME [ "/tk5/conf","/tk5/local_conf","/tk5/local_scripts","/tk5/prt","/tk5/dasd","/tk5/pch","/tk5/jcl","tk5/log" ]
#CMD ["/tk5/mvs"]
EXPOSE 3270 8038



#unzip -q mvs-tk5.zip -d temp && cd temp/mvs-tk5 && mv * .. && cd .. && rm -r mvs-tk5
#https://www.prince-webdesign.nl/images/downloads/mvs-tk5.zip
