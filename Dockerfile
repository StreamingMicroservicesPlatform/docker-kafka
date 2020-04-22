# This is a dummy, see ./hooks/build
FROM adoptopenjdk:11.0.7_10-jre-hotspot-bionic@sha256:a119e89693cfca250cecc3756c5efb5fdf523d93d813003b3c2a1d29d8884211

RUN java -XX:+PrintFlagsFinal -version | grep -E "UseContainerSupport|MaxRAMPercentage|MinRAMPercentage|InitialRAMPercentage"
