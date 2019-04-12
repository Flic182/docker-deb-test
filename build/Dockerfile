ARG BASE_IMAGE=debian:latest
FROM $BASE_IMAGE

ARG EXTRA_INSTALLS=''

COPY InitEnv.sh /tmp
RUN chmod u+x /tmp/InitEnv.sh && /tmp/InitEnv.sh

COPY Entrypoint.sh /usr/local/bin
RUN chmod u+x /usr/local/bin/Entrypoint.sh

ENTRYPOINT ["Entrypoint.sh"]
CMD ["/bin/bash"]
