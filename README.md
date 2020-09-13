## docker.openmpi

With the code in this repository, you can build a Docker container that provides
the OpenMPI runtime and tools along with various supporting libaries.  The
container also runs an OpenSSH server so that multiple containers can be linked
together and used via `mpirun`.

## Start an MPI Container Cluster

While containers can in principle be started manually via `docker run`, we suggest that your use 
[Docker Compose](https://docs.docker.com/compose/), a simple command-line tool 
to define and run multi-container applications. We provde a sample `docker-compose.yml`
file in the repository:

```
mpihead:
  image: mpi
  ports: 
   - "22"
  links: 
   - mpinode
  volumes:
   - ./code:/home/mpi/code

mpinode: 
  image: mpi
```

The file defines an `mpihead` and an `mpinode`. Both containers run the same `openmpi` image. 
The only difference is, that the `mpihead` container exposes its SHH server to 
the host system, so you can log into it to start your MPI applications.

The following command will start one `mpihead` container and three `mpinode` containers: 

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
