FROM python:alpine

RUN apk update
RUN apk upgrade

RUN apk --update add libxml2-dev libxslt-dev libffi-dev gcc musl-dev libgcc openssl-dev curl
RUN apk add jpeg-dev zlib-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev
RUN apk add freetype freetype-dev
RUN apk add libpng libpng-dev
RUN apk add g++ make gcc ca-certificates
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

ARG TARGET=development

ADD . /code
WORKDIR /code
ENV PYTHONPATH /code
RUN pip install --no-cache-dir --upgrade -r requirements/$TARGET.txt
