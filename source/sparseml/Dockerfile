FROM quay.io/centos/centos:stream9

WORKDIR /opt/app-root/src

RUN dnf install -y wget libGL python3-pip \
 && dnf clean all

RUN mkdir -p /usr/local/lib/python3.9/site-packages \
 && cd /usr/local/lib/python3.9/site-packages

WORKDIR /workspace

COPY source/sparseml/requirements.txt ./

RUN pip install --no-cache-dir -r ./requirements.txt

USER 1001
WORKDIR /opt/app-root/src
