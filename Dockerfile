FROM maven:3.8.1-openjdk-11
WORKDIR /testdirectory
COPY . /testdirectory/
RUN  mvn dependency:resolve && mvn clean install -DskipTests