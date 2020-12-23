FROM sempre813/ubuntu-18.04
MAINTAINER sempre813

ENV DEBIAN_FRONTEND=noninteractive  
ENV ROOT_PASSWORD=root
ENV USER_PASSWORD=dblab

# kggseq, plink, annovar
RUN mkdir -p /tool/
COPY ./tools/kggseq.jar /tools/kggseq.jar
COPY ./tools/plink /tools/plink

RUN wget http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz \
&& tar -xzvf annovar.latest.tar.gz -C /tools/
RUN chmod -R 777 /tools/

# vcftools
RUN apt-get update && apt-get install -y vcftools

# rstudio-server
RUN update-alternatives --remove-all python3 \
    && ln -sf /usr/bin/python3.6 /usr/bin/python3
RUN apt-get update && apt-get install -y gdebi-core \
    && wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1093-amd64.deb \
    && gdebi -n rstudio-server-1.3.1093-amd64.deb
EXPOSE 8787

# user add
RUN apt-get update && \
      apt-get -y install sudo
RUN useradd -m dblab && echo "dblab:${USER_PASSWORD}" | chpasswd \
    && adduser dblab sudo

# ssh-server
RUN apt-get update \
    && apt-get install -y openssh-server \
    && mkdir /var/run/sshd

# make user .ssh
RUN mkdir /home/dblab/.ssh

## set password
RUN echo 'root:${ROOT_PASSWORD}' | chpasswd

##replace sshd_config
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
 && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
EXPOSE 22

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod 777 /root/entrypoint.sh
ENTRYPOINT [ "/root/entrypoint.sh" ]