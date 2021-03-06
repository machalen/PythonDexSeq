#########################################################
# Dockerfile to build Cutadapt container Based on Ubuntu
#########################################################

#Set the image based on Ubuntu
FROM ubuntu:14.04

#File Author/Maintainer
MAINTAINER Magdalena Arnal, marnal@imim.es

#Update the repository sources list and install essential libraries
RUN apt-get update && apt-get install --yes build-essential
RUN apt-get update -y && apt-get install -y wget git unzip bzip2 g++ make libbz2-1.0 libc6-dev libbz2-dev zlib1g-dev libpq-dev
RUN apt-get install -y samtools gfortran libhdf5-dev libatlas-base-dev

#Install pip and HTSeq required libraries
RUN apt-get install --yes python2.7-dev python-numpy python-matplotlib python-pip
RUN pip install -U pip
RUN pip install -U setuptools

#Install HTSeq we can't use pip
WORKDIR /usr/local/
RUN wget --no-check-certificate https://pypi.python.org/packages/source/H/HTSeq/HTSeq-0.6.1p1.tar.gz
RUN tar -zxvf HTSeq-0.6.1p1.tar.gz
WORKDIR HTSeq-0.6.1p1/
RUN python setup.py install
RUN chmod +x scripts/htseq-count
RUN chmod +x scripts/htseq-qa

#Install pysam to process bam files
RUN pip install pysam

# add htseq-count to path
ENV PATH $PATH:/usr/local/HTSeq-0.6.1p1/scripts

# Cleanup 
RUN rm -rf /usr/local/HTSeq-0.6.1p1.tar.gz

#Set wokingDir in /
WORKDIR /
