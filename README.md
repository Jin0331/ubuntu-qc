# **Ubuntu 18.04 Quality Control(QC) tools images**

---

**< QC tools >**
- KGGseq(http://pmglab.top/kggseq/) - 1.20
- PLINK(https://www.cog-genomics.org/plink/) - 1.90v
- ANNOVAR(https://annovar.openbioinformatics.org/en/latest/) - $Date: 2020-06-08 00:46:07
- VCFtools(http://vcftools.sourceforge.net/) - 0.1.13

**< Language & Platform >**

- R - 3.6.3
- Python 3.7
- Jupyter Hub
- VScode
- Rstudio Server

---

## **How to use this image**

<br>

```
docker run -dit -p [user_port]:8989 -p [jupyter_port]:8888 -p [rstudio-server_port]:8787 -p [ssh_port]:22 -e PASSWORD=[vscode-password] -e ROOT_PASSWORD=[root-password] -e USER_PASSWORD=[user-password] sempre813/ubuntu18.04-qc /bin/bash
```