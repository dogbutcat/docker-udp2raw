FROM alpine:3.19

# prepare everything
RUN apk update
RUN apk add vim lsof tar bind-tools
# RUN apk add py-pip libsodium
WORKDIR /opt/udp2raw
ENV PATH="/opt/udp2raw:${PATH}"
ENV UDP2RAW_VERSION=20230206.0


RUN wget https://github.com/wangyu-/udp2raw-tunnel/releases/download/${UDP2RAW_VERSION}/udp2raw_binaries.tar.gz &&\
	tar xzvf udp2raw_binaries.tar.gz

# copy pre-setting to workspace
COPY script script

# next need to excute in host
# enable ip_forward
# RUN sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/' /etc/sysctl.conf
# keep this code for set sysctl.conf for bbr kernel
# RUN echo 'net.core.default_qdisc = fq' >> /etc/sysctl.conf
# RUN echo 'net.ipv4.tcp_congestion_control = bbr' >> /etc/sysctl.conf
# active setting
# RUN sysctl -p

# RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
# RUN /sbin/service sshd start && /sbin/service sshd stop

ENV R_PORT="5678"
ENV R_IP=

# CMD ["/usr/sbin/sshd", "-D" ]
# find options here https://github.com/wangyu-/udp2raw-tunnel/blob/master/doc/README.zh-cn.md#%E5%91%BD%E4%BB%A4%E9%80%89%E9%A1%B9
# ENTRYPOINT ["udp2raw_amd64"]
ENTRYPOINT [ "./script/start.sh" ]
CMD ["udp2raw_amd64", "-s", "-l","0.0.0.0:1234", "--raw-mode", "faketcp", "-k", "passwd"]
