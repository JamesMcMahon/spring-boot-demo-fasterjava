# Faster Java!

Demo repo showing off [CDS](https://docs.spring.io/spring-framework/reference/integration/cds.html)
and [GraalVM](https://docs.spring.io/spring-boot/reference/packaging/native-image/index.html) to show off improved
starting times.

## Startup times

Average startup time over 20 runs. Using Docker on a Macbook Air M3 with 24gb.

| Type         | Average Startup Time in ms | Delta from Baseline |
|--------------|----------------------------|---------------------|
| Baseline JDK | 780                        | 0                   |
| CDS          | 510                        | 270                 |
| GraalVM      | 30                         | 750                 |
