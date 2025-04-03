# Faster Java!

Demo repo showing off the performance gains
from  [Class Data Sharing (CDS)](https://docs.spring.io/spring-framework/reference/integration/cds.html)
and [GraalVM Native Images](https://docs.spring.io/spring-boot/reference/packaging/native-image/index.html).

The project itself is about as simple as you can get. Single endpoint
plus [Spring Boot Actuator](https://docs.spring.io/spring-boot/reference/actuator/index.html#actuator).
Obviously real world projects will be substantially more complex but hopefully this is a helpful baseline for folks.

### Class Data Sharing (CDS)

Class Data Sharing (CDS) is a Java Virtual Machine (JVM) feature designed to reduce the startup time and memory
footprint
of Java applications. It achieves this by creating a shared archive of class metadata that can be loaded into memory at
runtime,
allowing multiple JVM instances to share common class data.

### GraalVM Native Images

GraalVM Native Images are a technology that allows Java applications to be compiled ahead-of-time into standalone,
platform-specific executables. These native executables start faster and consume less memory compared to traditional
Java applications running on the Java Virtual Machine (JVM).
This makes them particularly well-suited for cloud environments and microservices architectures,
where quick startup times and efficient resource utilization are critical.

## Startup times

Average startup time over 20 runs. Using Docker on a Macbook Air M3 with 24gb.

| Type                         | Average Startup Time in ms | Delta from Baseline |
|------------------------------|----------------------------|---------------------|
| Custom Docker (Baseline)     | 830                        | 0                   |
| Spring OCI                   | 780                        | 50                  |
| Custom Docker CDS            | 510                        | 320                 |
| Spring OCI CDS               | 510                        | 320                 |
| Custom Docker GraalVM Native | 30                         | 800                 |
| Spring OCI GraalVM Native    | 30                         | 800                 |

## Memory and CPU usage

Sample taken using

> watch -tn120 docker stats --no-stream

CPU is using 6 cores. CPU should be taken with a grain of salt, as it will fluxate quite a bit.
There is enough variance that order of magnitude should be the main focus.

Docker container run using

> docker run -p 8080:8080 -e 'JAVA_OPTS=-Xms512m -Xmx512m' fasterjavademo:0.0.1-SNAPSHOT

| Type                         | Memory Usage in MB | CPU Usage in % |
|------------------------------|--------------------|----------------|
| Custom Docker (Baseline)     | 165                | 0.36           |
| Spring OCI                   | 203                | 0.22           |
| Custom Docker CDS            | 165                | 0.39           |
| Spring OCI CDS               | 163                | 0.29           |
| Custom Docker GraalVM Native | 36                 | 0.03           |
| Spring OCI GraalVM Native    | 44                 | 0.03           |

## Repo layout

The repo contains build scripts for custom Docker images and Spring OCI images and scripts to measure startup times.

Branches

* `cds` - Sample project with CDS patches applied
* `graalvm` - Sample project with GraalVM Native Image patches applied