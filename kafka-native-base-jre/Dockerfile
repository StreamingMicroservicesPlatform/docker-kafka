FROM oracle/graalvm-ce@sha256:9c683cba2d1b40921509299cdec6f58412d245247fbb2ded38f1a4f3e3563fa5
RUN gu install native-image
RUN yum -y install snappy libzstd lz4 && yum clean all
