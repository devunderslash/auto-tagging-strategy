FROM tomcat:latest
LABEL maintainer="Dev"
RUN apt-get update && apt-get install -y curl
EXPOSE 8080
CMD ["catalina.sh", "run"]