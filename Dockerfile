FROM nvidia/cuda:10.1-devel-ubuntu18.04 as builder

WORKDIR /root

COPY ./cublas-example /root/cublas-example

RUN mkdir /root/build && cd /root/build && nvcc -O3 -lcublas -o cublas-example /root/cublas-example/cublas-example.c

RUN apt-get update && apt-get install -y --no-install-recommends wget

RUN wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage

RUN chmod +x /root/linuxdeploy-x86_64.AppImage && /root/linuxdeploy-x86_64.AppImage --appimage-extract

RUN /root/squashfs-root/AppRun --appdir /root/cublas-example.AppDir -e /root/build/cublas-example -i /root/cublas-example/cublas-example.png -d /root/cublas-example/cublas-example.desktop

FROM ubuntu:18.04

ENV NVIDIA_VISIBLE_DEVICES all

ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

ENV NVIDIA_REQUIRE_CUDA "cuda>=10.1 brand=tesla,driver>=384,driver<385 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411"

COPY --from=builder /root/cublas-example.AppDir /root/cublas-example.AppDir

WORKDIR /root/cublas-example.AppDir/usr/bin

CMD ./cublas-example


