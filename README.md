# Faster Java!

Demo repo showing off [CDS](https://docs.spring.io/spring-framework/reference/integration/cds.html)
and [GraalVM](https://docs.spring.io/spring-boot/reference/packaging/native-image/index.html) to show off improved
starting times.

## Startup times

Average startup time over 20 runs. Using Docker on a Macbook Air M3 with 24gb.

| Type                     | Average Startup Time in ms | Delta from Baseline |
|--------------------------|----------------------------|---------------------|
| Custom Docker (Baseline) | 830                        | 0                   |
| Spring OCI               | 780                        | 50                  |
| Custom Docker CDS        | 510                        | 320                 |
| Spring OCI CDS           | 510                        | 320                 |
| Spring OCI GraalVM       | 30                         | 800                 |
