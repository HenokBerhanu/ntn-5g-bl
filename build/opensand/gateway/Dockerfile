# sudo docker build -t opensand:gateway -f Dockerfile .
FROM pavja2/qpep:gateway

RUN rm /etc/apt/sources.list.d/opensand.list

# Install necessary tools
RUN apt-get update && apt-get install -y \
    iproute2 \
    iperf3 \
    iptables \
    curl \
    jq \
    && apt-get clean  
    
COPY config/gw.conf /etc/opensand/daemon.conf
COPY config/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
COPY pepsal /usr/bin/pepsal
ENTRYPOINT /bin/bash /tmp/entrypoint.sh
