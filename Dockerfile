FROM python:3-slim

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get install -y --no-install-recommends build-essential git net-tools iptables &&\
    apt-get install -y --no-install-recommends libpcap-dev libnetfilter-conntrack3 libnetfilter-log1 libnetfilter-log-dev libnetfilter-queue1

# https://wiki.debian.org/iptables#Current_status
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy &&\
    update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

RUN pip install --upgrade pip && pip install python-iptables libnetfilter

WORKDIR /app

RUN git clone https://github.com/commonism/iptables-trace.git

#RUN git clone https://github.com/commonism/python-libnetfilter.git && cd python-libnetfilter && python setup.py install
#RUN git clone https://github.com/teamredlabs/python-libnetfilter-log && cd python-libnetfilter-log && python setup.py install

#COPY . .

#ENV XTABLES_LIBDIR=/usr/lib/x86_64-linux-gnu
