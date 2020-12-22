FROM sempre813/ubuntu-18.04
MAINTAINER sempre813

ENV DEBIAN_FRONTEND=noninteractive  
RUN apt-get update

# kggseq, plink, annovar
RUN mkdir -p /tool/
COPY ./tools/kggseq.jar /tool/kggseq.jar
COPY ./tools/plink /tools/plink

RUN wget http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz \
&& tar -xzvf annovar.latest.tar.gz -C /tools/
RUN chmod -R 777 /tools/

# vcftools
RUN apt-get update && apt-get install -y vcftools

# rstudio-server
RUN apt-get install gdebi-core \
    && wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1093-amd64.deb \
    && gdebi rstudio-server-1.3.1093-amd64.deb \
    && rm -rf rstudio-server-1.3.1093-amd64.deb
EXPOSE 8787

# ssh-server
RUN apt-get update && 
    apt-get install -y openssh-server
    mkdir /var/run/sshd

## set password
RUN echo 'root:root' | chpasswd

##replace sshd_config
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
 && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]