FROM java:8
RUN groupadd app && useradd -g app -d /home/app -s /bin/sh -m app
USER app
ARG PROJECT_NAME
ARG JAR_FILE
RUN mkdir /home/app/${PROJECT_NAME}
WORKDIR /home/app/${PROJECT_NAME}
COPY target/${JAR_FILE} /home/app/${PROJECT_NAME}
COPY entrypoint.sh /home/app/${PROJECT_NAME}
ENV JAR_FILE=${JAR_FILE}
EXPOSE 6868
ENTRYPOINT ["bash", "./entrypoint.sh"]