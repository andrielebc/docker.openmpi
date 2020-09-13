## docker.openmpi

With the code in this repository, you can build a Docker container that provides the OpenMPI runtime and tools along with various supporting libaries. The container also runs an OpenSSH server so that multiple containers can be linked together and used via `mpirun`.

## Start an MPI Container Cluster

First, build a local container image with:

```
$> make build
```

The `docker-compose.yml` file defines an `mpihead` and an `mpinode`. Both containers run the same `openmpi` image. The only difference is, that the `mpihead` container exposes its SSH server to the host system, so you can log into it to start your MPI applications.

The following command will start one `mpihead` container and four `mpinode` containers: 

```
$> make NUMBER_OF_NODES=4 up
```

Once all containers are running, connect to mpihead with:

```
$> make connect
```

To shut down the containers, use:

```
$> make down
```

##Credits

This repository draws from work on https://github.com/dispel4py/docker.openmpi by O. Weidner and R. Filgueira
