FROM sempre813/ubuntu-18.04
MAINTAINER sempre813

ENV DEBIAN_FRONTEND=noninteractive  
ENV ROOT_PASSWORD=user
ENV USER_PASSWORD=user
ENV PASSWORD=user

# user add
RUN apt-get update && \
      apt-get -y install sudo
RUN adduser --disabled-password --gecos '' dblab

## set password
RUN echo 'root:${ROOT_PASSWORD}' | chpasswd

##replace sshd_config
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
 && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
EXPOSE 22

# kggseq, plink, annovar
COPY ./tools/kggseq.jar /tools/kggseq.jar
COPY ./tools/plink /tools/plink

RUN wget http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz \
&& tar -xzvf annovar.latest.tar.gz -C /tools/
RUN chmod -R 777 /tools/

# vcftools
RUN apt-get update && apt-get install -y vcftools

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod 777 /root/entrypoint.sh
ENTRYPOINT [ "/root/entrypoint.sh" ]