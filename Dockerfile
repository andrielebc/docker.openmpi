FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y openssh-server gcc gfortran binutils zip unzip vim\
                       wget curl git openmpi-bin openmpi-common libopenmpi-dev

RUN mkdir /var/run/sshd
RUN echo 'root:mpi' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN adduser --disabled-password --gecos "" mpi && \
    echo "mpi ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/mpi

RUN mkdir /home/mpi/.ssh/
ADD ssh/config /home/mpi/.ssh/config
ADD ssh/id_rsa.mpi /home/mpi/.ssh/id_rsa
ADD ssh/id_rsa.mpi.pub /home/mpi/.ssh/id_rsa.pub
ADD ssh/id_rsa.mpi.pub /home/mpi/.ssh/authorized_keys

RUN chmod -R 600 /home/mpi/.ssh/* && \
    chown -R mpi:mpi /home/mpi/.ssh

RUN export LD_LIBRARY_PATH=/usr/lib/openmpi/lib/

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
