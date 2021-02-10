#Base image
FROM ubuntu

#Do image configuration
RUN /bin/bash -c 'echo esto es un ejemplo del dockerfile'
ENV myCustomEnvVar="esto es un ejemplo."\
    otherEnvVar="This is also a sample."
