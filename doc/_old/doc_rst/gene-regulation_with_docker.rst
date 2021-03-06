<!-- output: html\_document: fig\_caption: yes highlight: zenburn
number\_sections: yes theme: cerulean toc: yes toc\_depth: 5
pdf\_document: fig\_caption: yes highlight: zenburn number\_sections:
yes toc: yes toc\_depth: 5 --- -->

-  `Get started with Docker! <#get-started-with-docker>`__

   -  `Create a Docker account <#create-a-docker-account>`__
   -  `Install Docker on your local
      host <#install-docker-on-your-local-host>`__
   -  `Create shared repositories and download source
      data <#create-shared-repositories-and-download-source-data>`__
   -  `Fetch the Docker image and run it with shared
      folders <#fetch-the-docker-image-and-run-it-with-shared-folders>`__
   -  `Execute the pipeline <#execute-the-pipeline>`__

-  `JVH / Mac <#jvh--mac>`__

    Note: this is a first draft. Tested in Ubuntu 14.04 64bits version.

Get started with Docker!
========================

Create a Docker account
-----------------------

Instructions `here <https://docs.docker.com/linux/step_five/>`__.

Install Docker on your local host
---------------------------------

Instructions for a linux install can be found
`here <https://docs.docker.com/linux/>`__, along with mac and windows
instructions. A useful script is availalable
`here <https://gist.github.com/bhgraham/ed9f8242dc610b1f38e5>`__ for a
debian install.

You can also install it on Ubuntu 14.04 (64bits) typing the following:

::

    #sudo apt-get update
    sudo apt-get -y install docker.io
    sudo usermod -aG docker <username>

You should now log out and in again from your Ubuntu session. This short
procedure was tested in a virtual machine under VirtualBox (see
corresponding tutorial).

.. raw:: html

   <!--sudo service docker start-->

You can test whether docker works properly:

::

    docker run hello-world

.. figure:: ../../img/docker_hello.png
   :alt: 

NB: it seems qwerty keyboard keeps popping up after docker install.
Switch back to azerty:

::

    setxkbmap fr

<!-- Run the following command:

::

    sudo apt-get --yes install docker

-->

Create shared repositories and download source data
---------------------------------------------------

In order to execute the study case GSE20870, you should enter the
following commands:

::

    export ANALYSIS_DIR=~/GSE20870-analysis
    mkdir $ANALYSIS_DIR
    cd $ANALYSIS_DIR

::

    mkdir data/GSM521934 
    wget -nc ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX%2FSRX021%2FSRX021358/SRR051929/SRR051929.sra -P data/GSM521934

    mkdir data/GSM521935
    wget -nc ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX%2FSRX021%2FSRX021359/SRR051930/SRR051930.sra -P data/GSM521935

Fetch the Docker image and run it with shared folders
-----------------------------------------------------

::

    docker pull rioualen/gene-regulation:2.0
    docker run -v $ANALYSIS_DIR:~/GSE20870-analysis -it rioualen/gene-regulation:2.0 /bin/bash

You can share as many folders as desired, using this syntax:
``-v /path/on/host/:/path/on/docker/``.

Execute the pipeline
--------------------

::

    snakemake -p -s gene-regulation/scripts/snakefiles/workflows/factor_workflow.py --configfile gene-regulation/examples/GSE20870/GSE20870.yml

<!-- # JVH / Mac

Quick tour
----------

On Mac OSX

1. Install docker
~~~~~~~~~~~~~~~~~

::

        https://docs.docker.com/engine/installation/mac/

2. Open the application Docker Quickstart Terminal. This open a new terminal window and launches the docker daemon.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

3. Get the gene-regulation docker
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

docker pull rioualen/gene-regulation:0.3

4. Check the list of docker images available locally
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

docker images

5. Start the gene-regulation image. The option ``-it`` specifies the interactive mode, which is necessary to be able using this VM
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    docker run -it rioualen/gene-regulation:0.3 /bin/bash

You are now in a bash session of a gene-regulation docker. In this
session, you are "root" user, i;e. you have all the administration
rights. You can check this easily:

::

    whoami

6. Check the disks available on this docker
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    df -h

Currently, your docker can only access its local disk, which comes with
the VM. **Beware**: any data stored on this local disk will be lost when
you shut down the gene-regulation docker.

7. Exit and get back to your gene-regulation container
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you exits your shell session, the docker will still be running.

::

    exit

You are now back to the host terminal.

Check the currently active docker containers (processes).

::

    docker ps -a

Note that you can run several containers of the same image. Each active
container has a unique identifier which appears in the first column when
you run ``docker ps`` (e.g. ``faff5298ef95``). You can re-open a running
container with the command

::

    docker attach [CONTAINER_ID]

where ``[CONTAINER_IDR]`` must be replaced by the actual ID of the
running docker container (e.g. ``faff5298ef95``).

8. Shutting down the container
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We will now shut down this image, and start a new one which will enable
you to store persistent data.

::

    docker stop [CONTAINER_ID]

9. Starting a docker container with a shared folder.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

500 docker pull rioualen/gene-regulation:0.3 501 mkdir -p
~/gene-regulation\_data/GSE20870/GSM521934
~/gene-regulation\_data/GSE20870/GSM521935 502 cd
~/gene-regulation\_data/GSE20870/GSM521934 503 wget
ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX%2FSRX021%2FSRX021358/SRR051929/SRR051929.sra
504 cd ~/gene-regulation\_data/GSE20870/GSM521935 505 wget
ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX%2FSRX021%2FSRX021359/SRR051930/SRR051930.sra
506 mkdir ~/gene-regulation\_data/results/GSE20870 507 mkdir -p
~/gene-regulation\_data/results/GSE20870 508 docker pull
rioualen/gene-regulation:0.3 509 docker run -v
~/gene-regulation\_data:/data -it rioualen/gene-regulation:0.3 /bin/bash

10. Running the snakemake demo workflow on the docker container
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    1  ls /data
    2  ls /data/GSE20870/
    3  ls /data/GSE20870/GSM521934/
    4  exit
    5  ls /data
    6  source ~/bin/ngs_bashrc
    7  snakemake -s scripts/snakefiles/workflows/factor_workflow.py -np
    8  history
    9  snakemake -s scripts/snakefiles/workflows/factor_workflow.py -np

10 snakemake -s scripts/snakefiles/workflows/factor\_workflow.py -p

Questions
---------

1. Quand on fait un login dans la vm gene--regulation, on entre dans un
   shell basique (pas bash). Est-il possible de configurer docker pour
   qu'on entre automatiquement en bash ?

Entry point /bin/bash

2. Il faut ajouter le bashrc dans le /etc du docker.

-->
