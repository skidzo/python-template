FROM python:alpine

RUN \
    apk update && \
    apk upgrade && \
    apk add --no-cache postgresql-libs && \
    apk add --no-cache --virtual .build-deps gcc libgcc python3-dev musl-dev postgresql-dev && \
    apk add --no-cache libxml2-dev libxslt-dev libffi-dev openssl-dev curl && \
    apk add --no-cache jpeg-dev zlib-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev && \
    apk add --no-cache freetype freetype-dev && \
    apk add --no-cache libpng libpng-dev && \
    apk add --no-cache g++ make ca-certificates

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

ARG TARGET=development

ADD . /code
WORKDIR /code
ENV PYTHONPATH /code
RUN pip install --no-cache-dir --upgrade -r requirements/$TARGET.txt

RUN apk --purge del .build-deps
