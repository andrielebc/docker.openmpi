NUMBER_OF_NODES=4

build:
	docker build -t mpi .
up: build
	docker-compose scale mpihead=1 mpinode=$(NUMBER_OF_NODES)
down:
	docker-compose down
connect:
	chmod 400 ssh/id_rsa.mpi
	ssh -i ssh/id_rsa.mpi -p `./get_port.sh` mpi@localhost
