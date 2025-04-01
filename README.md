# Faster Java!

Demo repo showing off [CDS](https://docs.spring.io/spring-framework/reference/integration/cds.html)
and [GraalVM](https://docs.spring.io/spring-boot/reference/packaging/native-image/index.html) to show off improved
performance.

## Startup times

Average startup time over 20 runs. Using Docker on a Macbook Air M3 with 24gb.

| Type                     | Average Startup Time in ms | Delta from Baseline |
|--------------------------|----------------------------|---------------------|
| Custom Docker (Baseline) | 830                        | 0                   |
| Spring OCI               | 780                        | 50                  |
| Custom Docker CDS        | 510                        | 320                 |
| Spring OCI CDS           | 510                        | 320                 |
| Custom Docker GraalVM    | 30                         | 800                 |
| Spring OCI GraalVM       | 30                         | 800                 |

## Memory and CPU usage

Sample taken using

> watch -tn120 docker stats --no-stream

CPU is using 6 cores. CPU should be taken with a grain of salt, as it will fluxate quite a bit.
There is enough variance that order of magnitude should be the main focus.

Docker container run using

> docker run -p 8080:8080 -e 'JAVA_OPTS=-Xms512m -Xmx512m' fasterjavademo:0.0.1-SNAPSHOT

| Type                     | Memory Usage in MB | CPU Usage in % |
|--------------------------|--------------------|----------------|
| Custom Docker (Baseline) | 165                | 0.36           |
| Spring OCI               | 203                | 0.22           |
| Custom Docker CDS        | 165                | 0.39           |
| Spring OCI CDS           | 163                | 0.29           |
| Custom Docker GraalVM    | 36                 | 0.03           |
| Spring OCI GraalVM       | 44                 | 0.03           |

## Repo layout

The repo contains build scripts for custom Docker images and Spring OCI images and scripts to measure startup times.

Branches

* `cds` - Sample project with CDS patches applied
* `graalvm` - Sample project with GraalVM patches applied