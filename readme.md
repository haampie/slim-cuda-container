# Slimming big CUDA Docker images with multistage builds and application bundling

Building an image and running a CUBLAS demo:

```
$ git clone https://github.com/haampie/slim-cuda-container.git
$ cd slim-cuda-container
$ docker build . -t cublas-example
$ docker run --gpus all cublas-example 
      1      7     13     19     25     31
      2      8     14     20     26     32
      3   1728    180    252    324    396
      4    160     16     22     28     34
      5    176     17     23     29     35
```

The image size:

```
$ docker images
REPOSITORY          TAG                        IMAGE ID            CREATED             SIZE
cublas-example      latest                     087a225d9309        2 minutes ago       159MB
```

This is basically just shipping the Ubuntu 18.04 base image + libcublas.so and its dependencies.

Extending the `nvidia/cuda` runtime image instead would result in 1.5GB image.
