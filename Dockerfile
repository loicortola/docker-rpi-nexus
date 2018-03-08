FROM leadowl/rpi-openjdk
ENV NEXUS_VERSION=3.9.0-01
RUN wget https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-$NEXUS_VERSION-unix.tar.gz -O /tmp/nexus-$NEXUS_VERSION-unix.tar.gz && \
        useradd -r -u 200 -m -c "nexus role account" -d /opt/sonatype-work -s /bin/false nexus && \
        mkdir -p /opt/sonatype/ && \
        mkdir -p /opt/sonatype-work && \
        tar -C /opt/sonatype/ -xvaf /tmp/nexus-$NEXUS_VERSION-unix.tar.gz && \
        ln -s /opt/sonatype/nexus-$NEXUS_VERSION/ /opt/sonatype/nexus && \
        rm -f /tmp/nexus-$NEXUS_VERSION-unix.tar.gz && \
        chown -Rv nexus:nexus /opt/sonatype/nexus && \
        chown -Rv nexus:nexus /opt/sonatype/nexus-$NEXUS_VERSION && \
        chown -Rv nexus:nexus /opt/sonatype-work

VOLUME /opt/sonatype-work

WORKDIR /opt/sonatype/nexus

COPY nexus.vmoptions /opt/sonatype/nexus/bin/nexus.vmoptions

USER nexus
CMD ["/opt/sonatype/nexus/bin/nexus", "run"]
