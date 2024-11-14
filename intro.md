% Savio introductory training: Basic usage of the Berkeley Savio high-performance computing cluster
% November 14, 2024
% Noah Baker and Chris Paciorek


# Hiring and other notes

 - We offer platforms and services for researchers working with [sensitive data](https://docs-research-it.berkeley.edu/services/srdc/)

 - Get paid to develop your skills in research data and computing! Berkeley's Research IT is hiring graduate student Domain Consultants for flexible appointments, 15% to 25% effort (6-10 hours/week). We are seeking diverse and curious candidates from across scholarly disciplines who are enthusiastic about supporting campus research! Email your cover letter and CV to: `research-it@berkeley.edu`.
 
# How to get additional help

 - Check the Status and Announcements page:
    - [https://research-it.berkeley.edu/services/high-performance-computing/status-and-announcements](https://research-it.berkeley.edu/services/high-performance-computing/status-and-announcements)
 - For technical issues and questions about using Savio:
    - brc-hpc-help@berkeley.edu
 - For questions about computing resources in general, including cloud computing:
    - brc@berkeley.edu
    - office hours: office hours: Wed. 1:30-3:00 and Thur. 9:30-11:00 [on Zoom](https://research-it.berkeley.edu/programs/berkeley-research-computing/research-computing-consulting)
 - For questions about data management (including HIPAA-protected data):
    - researchdata@berkeley.edu
    - office hours: office hours: Wed. 1:30-3:00 and Thur. 9:30-11:00 [on Zoom](https://research-it.berkeley.edu/programs/berkeley-research-computing/research-computing-consulting)

# Introduction

We'll do this mostly as a demonstration. We encourage you to login to your account and try out the various examples yourself as we go through them.

Much of this material is based on the extensive Savio documention we have prepared and continue to prepare, available at [https://docs-research-it.berkeley.edu/services/high-performance-computing/](https://docs-research-it.berkeley.edu/services/high-performance-computing/).

The materials for this tutorial are available using git at the short URL ([tinyurl.com/brc-nov24](https://tinyurl.com/brc-nov24)), the  GitHub URL ([https://github.com/ucb-rit/savio-training-intro-fall-2024](https://github.com/ucb-rit/savio-training-intro-fall-2024)), or simply as a [zip file](https://github.com/ucb-rit/savio-training-intro-fall-2024/archive/main.zip).

# Outline

This training session will cover the following topics:

 - Introductory content
     - Basic parallel computing concepts
     - High level overview of system
 - System capabilities and hardware
     - Getting access to the system - FCA, condo, ICA
     - Login nodes, compute nodes, and DTN nodes
     - Savio computing nodes
     - Disk space options (home, scratch, group, condo storage)
 - Logging in and data transfer
     - Logging in
     - Data transfer
        - SCP/SFTP
        - Globus
        - Box & bDrive (Google drive)
 - Software
     - Software modules
 - Submitting and monitoring jobs
     - Acounts and partitions
     - Basic job submission
       - Per-core and per-node scheduling
     - Parallel jobs
     - GPU jobs
     - Interactive jobs
     - Low-priority queue
     - Monitoring jobs and cluster status
 - Open OnDemand (OOD)
     - Jupyter notebooks using OOD
     - Parallelization in Python with ipyparallel


# Introduction to High Performance Computing (HPC)

- What is High Performance Computing?
  - HPC involves using big computers and parallel processing to run applications efficiently, reliably, and quickly.
  - It’s like having hundreds of powerful computers working together to solve large and complex problems.
- What is Savio?
  - In layman's terms:
    - A collection of really powerful computers (nodes)
    - Some really big, fast hard drives
- Two types of parallel Computing
  - Shared memory (e.g., OpenMP)
    - All computation on the same node
    - Can have shared objects in RAM in some cases
  - Distributed memory (e.g., MPI)
    - Computation on multiple nodes
    - Special attention to passing information between nodes


# System capabilities and hardware

- Savio is a >600-node, >15,000-core Linux cluster rated at nearly 540 peak teraFLOPS.
   - about 40% of the  compute nodes provided by the institution for general access
   - about 60% compute nodes contributed by researchers in the Condo program
 


# Savio System Update: Rocky 8

Savio has been upgraded to the Rocky 8 operating system.

- Key Changes with Rocky 8:
  - Enhanced security features
  - Improved system performance
  - Better compatibility with the latest software and applications
- Notes for users:
  - MODULEPATH locations have changed from Scientific Linux 7 (prior version)
  - Some different modules available with Rocky 8, plus updated versions of software
  - OOD logon now uses CalNet authentication via CILogon


# The Savio cluster

Savio is a Linux cluster - by cluster we mean a set of computers networked together

- Savio has 3 kinds of nodes:
  - Login nodes
  - Data transfer nodes
  - Compute nodes


# Conceptual diagram of Savio

<center><img src="savio_diagram_2.jpg"></center>


# Getting access to the system - FCA and condo

- All regular Berkeley faculty can request 300,000 service units (roughly core-hours) per year through the [Faculty Computing Allowance (FCA)](https://docs-research-it.berkeley.edu/services/high-performance-computing/getting-account/faculty-computing-allowance/)
- Researchers can also purchase nodes for their own priority access and gain access to the shared Savio infrastructure and to the ability to *burst* to additional nodes through the [condo cluster program](https://docs-research-it.berkeley.edu/services/high-performance-computing/condos/condo-cluster-service/)
- Instructors can request an [Instructional Computing Allowance (ICA)](https://docs-research-it.berkeley.edu/services/high-performance-computing/getting-account/instructional-computing-allowance/).
- The application process has gotten even easier with the introduction of the [MyBRC](https://mybrc.brc.berkeley.edu/), the Berkeley Research Computing Access Management System
- Please bear in mind that applications have to be manually reviewed before they can be approved.

Faculty/principal investigators can allow researchers working with them to get user accounts with access to the FCA or condo resources available to the faculty member.


# Login nodes

- Login nodes
  - Used to access the system when logging in
  - For login and non-intensive interactive work such as:
    - job submission and monitoring
    - basic compilation
    - managing your disk space

# Data transfer nodes

- Data transfer nodes
  - For transferring data to/from Savio
  - This is a notable difference from many other clusters
    - Login node: `hpc.brc.berkeley.edu`
    - Data transfer node: `dtn.brc.berkeley.edu`
    - Some applications may look for SFTP via login node
- Note: you can access your files on the system from any of the computers

# Compute nodes

- Compute nodes
  - For computational tasks
  - Your work might use parallelization to do computation on more than one CPU
  - You can also run "serial" jobs that use a single CPU

# Savio computing node types

- There are multiple types of computation nodes with different hardware specifications [(see the *Hardware Configuration* page)](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/hardware-config/).

- The nodes are divided into several pools, called *partitions*
- These partitions have different restrictions and costs associated with them
   - [see the *Scheduler Configuration* page](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/running-your-jobs/scheduler-config/)
  - and [the associated costs in Service Units](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/running-your-jobs/service-units-savio/)

- Any job you submit must be submitted to a partition to which you have access.


# Disk space options (home, scratch, group, condo storage)

- You have access to the multiple kinds of disk space, described [here in the *Storing Data* page](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/storing-data/).
- There are 3 directories:
  - `/global/home/users/SAVIO_USERNAME`
    - 30 GB per user, backed up
  - `/global/home/groups/SAVIO_GROUPNAME`
    - Per group: 30 GB for FCA, 200 GB for Condo
  - `/global/scratch/users/SAVIO_USERNAME`
    - Connected via Infiniband (very fast)
    - Primary data storage during computation
- All 3 are available from any of the nodes and changes to files when using one node will be seen on all the other nodes
- Large amounts of disk space is available for purchase from the [*condo storage* offering](https://docs-research-it.berkeley.edu/services/high-performance-computing/condos/condo-storage-service/).
  - The minimum purchase is about $5,750, which provides roughly 112 TB for five years.

# Using disk space

- When reading/writing data to/from disk put the data in your scratch space at `/global/scratch/users/SAVIO_USERNAME`
- The system is set up so that disk access for all users is optimized when users are doing input/output (I/O) off of scratch rather than off of their home directories
- Doing I/O with files on your home directory can impact the ability of others to access their files on the filesystem


# Sensitive Data on Savio

- Savio (and AEoD) is [certified for moderately sensitive data](https://docs-research-it.berkeley.edu/services/high-performance-computing/getting-account/sensitive-accounts/)
  - P2, P3 (formerly PL1) and NIH dbGap (non-"notice-triggering" data).
- PIs/faculty must request a P2/P3 project alongside requests for a new FCA/condo allocation
  - Existing projects can't be converted to P2/P3 projects.
- BRC has a new-ish platform for highly sensitive data (P4) called SRDC.

More info is available in [our documentation](https://docs-research-it.berkeley.edu/services/srdc/) or on [our website](https://research-it.berkeley.edu/services-projects/secure-research-data-computing).


# Conceptual diagram of Savio

<center><img src="savio_diagram_2.jpg"></center>


# Logging in: Getting Set Up

- To login, you need to have software on your own machine that gives you access to the SSH command
  - These come built-in with Mac (see `Applications -> Utilities -> Terminal`).
  - For Windows, you can use Powershell (or Command Prompt)
    - Other applications such as [MobaXterm](https://mobaxterm.mobatek.net/) may offer more functionality
- You also need to set up your smartphone or tablet with *Google Authenticator* to generate one-time passwords for you.
- Here are instructions for [doing this setup, and for logging in](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/logging-brc-clusters/).

# Logging in

Then to login:
```
ssh SAVIO_USERNAME@hpc.brc.berkeley.edu
```

- Then enter XXXXXYYYYYY where XXXXXX is your PIN and YYYYYY is the one-time password. YYYYYY will be shown when you open your *Google authenticator* app on your phone/tablet.

- One can then navigate around and get information using standard UNIX commands such as `ls`, `cd`, `du`, `df`, etc.
  - There is a lot of material online about using the UNIX command line
    - Also called the shell; 'bash' is one common variation
  - Here is one [basic tutorial from Software Carpentry](https://swcarpentry.github.io/shell-novice) and [another one from the Berkeley Statistical Computing Facility](https://computing.stat.berkeley.edu/tutorial-unix-basics/).

# Graphical Interface

If you want to be able to open programs with graphical user interfaces:
```
ssh -Y SAVIO_USERNAME@hpc.brc.berkeley.edu
```

- To display the graphical windows on your local machine, you'll need X server software on your own machine to manage the graphical windows
  - For Windows, your options include *MobaXterm*, *eXceed*, or *Xming*
  - For Mac, there is *XQuartz*
  
An option that will often be better is to use Open OnDemand (ood.brc.berkeley.edu) to access Savio via your browser.

# Logging in (via browser using Open OnDemand)

Alternatively one can login via OOD to access Savio:

- Connect to [ood.brc.berkeley.edu](https://ood.brc.berkeley.edu).
  - Login via CILogon (select UC Berkeley) with your CalNet credentials.
- You can then access the OOD services at the top of the page.
  - For a terminal, click on "Clusters" and then "BRC Shell Access"


# Editing files

You are welcome to edit your files on Savio (rather than copying files back and forth from your laptop and editing them on your laptop). To do so you'll need to use some sort of editor. Savio has `vim`, `emacs`, and `nano` installed. Just start the editor from a login node.

```
## To use vim
vim myfile.txt
## To use emacs
emacs myfile.txt
## To use nano
module load nano
nano myfile.txt
```

# Data transfer with examples to/from laptop, Box, Google Drive, AWS

To do any work on the system, you'll usually need to transfer files (data files, code files, etc.) to the Savio filesystem, either into your home directory, your scratch directory or a group directory.

And once you're done with a computation, you'll generally need to transfer files back to another place (e.g., your laptop).

Let's see how we would transfer files/data to/from Savio using a few different approaches.

# Data transfer for smaller files: SCP

- The most common command line protocol for file transfer is *SCP*

- You need to use the Savio data transfer node, `dtn.brc.berkeley.edu`.

- The example file `bayArea.csv` is too large to store on Github; you can obtain it [here](https://www.stat.berkeley.edu/share/paciorek/bayArea.csv).

- SCP is supported in terminal for Mac/Linux and in Powershell/Command Prompt in Windows

```bash
# to Savio, while on your local machine
scp bayArea.csv $USER@dtn.brc.berkeley.edu:~/.
scp bayArea.csv $USER@dtn.brc.berkeley.edu:~/data/newName.csv
scp bayArea.csv $USER@dtn.brc.berkeley.edu:/global/scratch/users/$USER/.

# from Savio, while on your local machine
scp $USER@dtn.brc.berkeley.edu:~/data/newName.csv ~/Documents/.
```

If you can ssh to your local machine or want to transfer files to other systems on to which you can ssh, you can login to the dtn node to execute the scp commands:

```
ssh SAVIO_USERNAME@dtn.brc.berkeley.edu
[SAVIO_USERNAME@dtn ~]$ scp ~/file.csv OTHER_USERNAME@other.domain.edu:~/data/.
```

If you're already connected to a Savio login node, you can use `ssh dtn` to login to the dtn.

Pro tip: You can package multiple files (including directory structure) together using tar
```
tar -cvzf files.tgz dir_to_zip
# to untar later:
tar -xvzf files.tgz
```

# Data transfer for smaller files: SFTP

- Another common method for file transfer is *SFTP*
- A multi-platform program for doing transfers via SFTP is [FileZilla](https://filezilla-project.org/).
- After logging in to most *SFTP* applications, you'll see windows for the Savio filesystem and your local filesystem on your machine. You can drag files back and forth.


# Data transfer for larger files: Globus, Intro

- You can use Globus Connect to transfer data data to/from Savio (and between other resources) quickly and unattended
  - This is a better choice for large transfers
  - Here are some [instructions](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/transferring-data/using-globus-connect-savio/).

- Globus transfers data between *endpoints*
  - Possible endpoints include
    - Savio
    - your laptop or desktop
    - Other clusters like NERSC and ACCESS (XSEDE)
    - bDrive
    - Collaborators & other researchers not on savio

# Data transfer for larger files: Globus, requirements

- If you are transferring to/from your laptop, you'll need
  1. Globus Connect Personal set up,
  2. your machine established as an endpoint, and
  3. Globus Connect Personal actively running on your machine. At that point you can proceed as below.

- Savio's endpoint is named `ucb#brc`.

# Data transfer for larger files: Globus, Setup

- To transfer files, you open Globus at [globus.org](https://globus.org) and authenticate to the endpoints you want to transfer between.
  - This means that you only need to authenticate once, whereas you might need to authenticate multiple times with scp and sftp.
  - You can then start a transfer and it will proceed in the background, including restarting if interrupted.

- Globus also provides a [command line interface](https://docs.globus.org/cli/) that will allow you to do transfers programmatically
  - Thus a transfer could be embedded in a workflow script.


# Data transfer: Box & bDrive

- Box and bDrive (the Cal branded Google Drive) both provide free, secured, and encrypted content storage of files to Berkeley affiliates
  - However, recent quotas imposed on Box and bDrive now limit their usefulness for research data
  - Box quotas
    - 50GB for new individual accounts
    - 500GB for new Special Purpose Accounts ("SPAs")
  - bDrive quotas
    - 50GB for new individual accounts
    - 150GB for existing individual accounts
  - bDrive has a maximum file size of 5Tb, Box has a maximum file size of 15 Gb
- Alternative paid options are also available
  - Cloud storage options include Amazon, Google, Microsoft Azure, and Wasabi
    - See the [bCloud web page](https://technology.berkeley.edu/services/cloud) for more information
  - As mentioned earlier, Condo computing contributors can also buy into the condo storage program

# Data transfer: Box and bDrive Access

- You can interact with both services via web browser, and both services provide a desktop app you can use to move and sync files between your computer and the cloud.
  - [Box web app](http://box.berkeley.edu)
  - [Box desktop app](https://www.box.com/resources/downloads)
  - [bDrive web app](http://bdrive.berkeley.edu/)
  - [Drive desktop app](https://www.google.com/drive/download/)


For more ambitious users, Box has a Python-based SDK that can be used to write scripts for file transfers. For more information on how to do this, check out the `BoxAuthenticationBootstrap.ipynb` and `TransferFilesFromBoxToSavioScratch.ipynb` from BRC's cyberinfrastructure engineer on [GitHub](https://github.com/ucberkeley/brc-cyberinfrastructure/tree/dev/analysis-workflows/notebooks)

# Data transfer: Box & bDrive with rclone setup

[*rclone*](https://rclone.org/) is a command line program that you can use to sync files between both services and Savio. You can read instructions for using rclone on Savio [with Box or bDrive here](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/transferring-data/rclone-box-bdrive/).

Briefly the steps to set up *rclone* on Savio to interact with Box are as follows:

- Configuration (on dtn): ```rclone config```
 - Use auto config? -> n
 - For Box: install rclone on your PC, then run ```rclone authorize "box"```
 - Paste the link into your browser and log in to your CalNet account
 - Copy the authentication token and paste into the ```rclone config``` prompt on Savio

 Finally you can set up [special purpose accounts](https://calnetweb.berkeley.edu/calnet-departments/special-purpose-accounts-spa) so files are owned at a project level rather than by individuals.


# Data transfer: Box & bDrive with rclone practice

*rclone* basics:

- Switch to DTN before using if on login node
  - Use command ```ssh dtn```
  - If using *rclone* on another node You need to load *rclone* before use
    - Run command ```module load rclone```
- All *rclone* commands begin with ```rclone``` and are then followed by a commands
  - The commands are different from bash (i.e., ```cp``` in *bash* vs. ```copy``` in rclone)
- To reference a file on the remote you add configured remote name followed by a colon followed by the file path
  - For example ```clint_bdrive:project_folder```
  - To access the main folder leave nothing after the colon (e.g., ```clint_bdrive:```)
- For more tips and tricks see [our docs](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/transferring-data/rclone-box-bdrive/)

*rclone* example:
```
rclone listremotes # Lists configured remotes.
rclone lsd remote_name: # Lists directories, but not files. Note the trailing colon.
rclone size remote_name:home # Prints size and number of objects in remote "home" directory. This can take a very long time when tallying Tbs of files.
rclone copy /global/home/users/hannsode remote_name:savio_home/hannsode # Copies my entire home directory to a new directory on the remote.
rclone copy /global/scratch/users/hannsode/genomes remote_name:genome_sequences # Copies entire directory contents to a dirctory on the remote with a new name.
```

# Software modules

A lot of software is available on Savio but needs to be loaded from the relevant software module before you can use it.

(We do this not to confuse you but to avoid clashes between incompatible software and allow multiple versions of a piece of software to co-exist on the system.)

```
module list  # What's loaded?
module avail  # What's available?
```

One thing that tricks people is that some the modules are arranged in a hierarchical (nested) fashion, so you only see some of the modules as being available *after* you load the parent module (e.g., MKL, FFT, and HDF5/NetCDF software are nested within the gcc module). Here's how we see and load MPI.

```
module load openmpi  # This fails if gcc not yet loaded.
module spider openmpi
module spider openmpi/4.1.6
module load gcc/13.2.0
module avail
module load openmpi
```

# Python and R (changes with Rocky 8)

Here are some core modules for data analysis and machine learning:

- `python`: Python 3.11.6 with a some useful Python packages
- `anaconda3`: Python 3.11.7 with many useful Python packages plus Conda-related tools
- `ml/pytorch`: Python 3.11.7 with PyTorch
- `r`: R 4.4.0 with some useful R packages
- `r-spatial`: GIS/spatial-related R packages

# Submitting jobs: overview

All computations are done by submitting jobs to the scheduling software that manages jobs on the cluster, called SLURM.

Why is this necessary? Otherwise your jobs would be slowed down by other people's jobs running on the same node. This also allows everyone to share Savio in a fair way.

The basic workflow is:

 - Login to Savio (SSH or via ood.brc.berkeley.edu).
    - You'll end up on one of the login nodes in your home directory.
 - Use `cd` to go to the directory from which you want to submit the job.
 - Submit the job using `sbatch` (or an interactive job using `srun`, discussed later).
    - When your job starts, the working directory will be the one from which the job was submitted.
    - The job will be running on a compute node, not the login node.

# Submitting jobs: accounts and partitions

When submitting a job, the main things you need to indicate are the project account you are using and the partition. Note that there is a default value for the project account, but if you have access to multiple accounts such as an FCA and a condo, it's good practice to specify it.

You can see what accounts you have access to and which partitions within those accounts as follows:

```
sacctmgr -p show associations user=$USER
```

Here's an example of the output for a user who has access to an FCA and a condo:
```
Cluster|Account|User|Partition|Share|GrpJobs|GrpTRES|GrpSubmit|GrpWall|GrpTRESMins|MaxJobs|MaxTRES|MaxTRESPerNode|MaxSubmit|MaxWall|MaxTRESMins|QOS|Def QOS|GrpTRESRunMins|
brc|fc_paciorek|paciorek|savio4_gpu|1|||||||||||||a5k_gpu4_normal,savio_lowprio|a5k_gpu4_normal||
brc|fc_paciorek|paciorek|savio4_htc|1|||||||||||||savio_debug,savio_normal|savio_normal||
brc|fc_paciorek|paciorek|savio3_gpu|1|||||||||||||a40_gpu3_normal,gtx2080_gpu3_normal,savio_lowprio,v100_gpu3_normal|gtx2080_gpu3_normal||
brc|fc_paciorek|paciorek|savio3_htc|1|||||||||||||savio_debug,savio_normal|savio_normal||
brc|fc_paciorek|paciorek|savio3_bigmem|1|||||||||||||savio_debug,savio_normal|savio_normal||
brc|fc_paciorek|paciorek|savio3|1|||||||||||||savio_debug,savio_normal|savio_normal||
brc|fc_paciorek|paciorek|savio2_1080ti|1|||||||||||||savio_debug,savio_normal|savio_normal||
brc|fc_paciorek|paciorek|savio2_knl|1|||||||||||||savio_debug,savio_normal|savio_normal||
brc|fc_paciorek|paciorek|savio2_gpu|1|||||||||||||savio_debug,savio_normal|savio_normal||
brc|fc_paciorek|paciorek|savio2_htc|1|||||||||||||savio_debug,savio_long,savio_normal|savio_normal||
brc|fc_paciorek|paciorek|savio2_bigmem|1|||||||||||||savio_debug,savio_normal|savio_normal||
brc|fc_paciorek|paciorek|savio2|1|||||||||||||savio_debug,savio_normal|savio_normal||
brc|fc_paciorek|paciorek|savio|1|||||||||||||savio_debug,savio_normal|savio_normal||
brc|fc_paciorek|paciorek|savio_bigmem|1|||||||||||||savio_debug,savio_normal|savio_normal||
brc|co_stat|paciorek|savio3_gpu|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio4_gpu|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio4_htc|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio3_htc|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio3_bigmem|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio3|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio2_1080ti|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio2_knl|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio2_bigmem|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio2_gpu|1|||||||||||||savio_lowprio,stat_gpu2_normal|stat_gpu2_normal||
brc|co_stat|paciorek|savio2_htc|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio_bigmem|1|||||||||||||savio_lowprio|savio_lowprio||
brc|co_stat|paciorek|savio2|1|||||||||||||savio_lowprio,stat_savio2_normal|stat_savio2_normal||
```

If you are part of a condo, you'll notice that you have *low-priority* access to certain partitions. For example, user 'paciorek' is part of the statistics condo *co_stat*, which purchased some `savio2` nodes and therefore has normal access to those, but he can also burst beyond the condo and use other partitions at low-priority (see below).

In contrast, through his FCA, 'paciorek' has access to the savio2, savio3, and savio4 partitions as well as various big memory, HTC, and GPU partitions, all at normal priority.

# Submitting a batch job

Let's see how to submit a simple job. If your job will only use the resources on a single node, you can do the following.

Here's an example job script that I'll run, requesting four cores. You'll need to modify the --account value and possibly the --partition value.

```bash
#!/bin/bash
# Job name:
#SBATCH --job-name=test
#
# Account:
#SBATCH --account=fc_paciorek
#
# Cores:
#SBATCH --cpus-per-task=4
#
# Partition:
#SBATCH --partition=savio3_htc
#
# Wall clock limit (5 minutes here):
#SBATCH --time=00:05:00
#
## Command(s) to run:
module load anaconda3/2024.02-1-11.4
python calc.py >& calc.out
```

Now let's submit and monitor the job:

```
sbatch job.sh

squeue -j <JOB_ID>

wwall -j <JOB_ID>
```

After a job has completed (or been terminated/cancelled), you can review the maximum memory used via the sacct command.

```
sacct -j <JOB_ID> --format=JobID,JobName,MaxRSS,Elapsed
```

MaxRSS will show the maximum amount of memory that the job used in kilobytes.

You can also login to the node where you are running and use commands like *top* and *ps*:

```
srun --jobid=<JOB_ID> --pty /bin/bash
```

NOTE: For the partitions not named *_htc and *_gpu, all jobs are given exclusive access to the entire node or nodes assigned to the job (**and your account is charged for all of the cores on the node(s)**).


# Parallel job submission

If you are submitting a job that uses multiple nodes, you'll need to carefully specify the resources you need. The key flags for use in your job script are:

 - `--nodes` (or `-N`): indicates the number of nodes to use
 - `--ntasks-per-node`: indicates the number of tasks (i.e., processes) one wants to run on each node
 - `--cpus-per-task` (or `-c`): indicates the number of cpus to be used for each task

In addition, in some cases it can make sense to use the `--ntasks` (or `-n`) option to indicate the total number of tasks and let the scheduler determine how many nodes and tasks per node are needed. In general `--cpus-per-task` will be one except when running threaded code.  

Here's an example job script for a job that uses MPI for parallelizing over multiple nodes:

```bash
#!/bin/bash
# Job name:
#SBATCH --job-name=test
#
# Account:
#SBATCH --account=account_name
#
# Partition:
#SBATCH --partition=partition_name
#
# Number of MPI tasks needed for use case (example):
#SBATCH --ntasks=40
#
# Processors per task:
#SBATCH --cpus-per-task=1
#
# Wall clock limit:
#SBATCH --time=00:00:30
#
## Command(s) to run (example):
module load intel openmpi
mpirun ./a.out
```

When you write your code, you may need to specify information about the number of cores to use. SLURM will provide a variety of variables that you can use in your code so that it adapts to the resources you have requested rather than being hard-coded.

Here are some of the variables that may be useful: `SLURM_NTASKS`, `SLURM_CPUS_PER_TASK`, `SLURM_NODELIST`, `SLURM_NNODES`.


# Parallel job submission patterns

Some common paradigms are:

 - 1 node, many CPUs
     - openMP/threaded jobs - 1 task, *c* CPUs for the task
     - Python/R/GNU parallel - many tasks, 1 per CPU at any given time
 - many nodes, many CPUs
     - MPI jobs that use 1 CPU per task for each of *n* tasks, spread across multiple nodes
     - Python/R/GNU parallel - many tasks, 1 per CPU at any given time
 - hybrid jobs that use *c* CPUs for each of *n* tasks
     - e.g., MPI+threaded code

We have lots more [examples of job submission scripts](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/running-your-jobs/scheduler-examples) for different kinds of parallelization (multi-node (MPI), multi-core (openMP), hybrid, etc.

# GPU jobs

Some [complications when submitting GPU jobs](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/running-your-jobs/submitting-jobs/#gpu-jobs):

 - `savio3_gpu` has several kinds of GPUs with different capabilities.
 - You must use the `--gres=gpu:TYPE:NUMBER` syntax (`TYPE` is often but not always needed).
 - You must request multiple cores per GPU (the number varies by GPU type).
 - GPU usage is charged per CPU core and is more expensive than using a CPU.
 - When using an FCA with certain GPU types you need to submit to a specific QoS via `-q`.
 - Occasionally GPUs become inaccessible and your job may fail to access the GPU.
 
In the next slide. we'll see we can get on a GPU node and see the GPUs.


# Interactive jobs

You can also do work interactively. This simply moves you from a login node to a compute node.

```
srun -A fc_paciorek -p savio3_gpu --gres=gpu:A40:1 -q a40_gpu3_normal -c 8 -t 10:0 --pty bash
```

Note that you end up in the same working directory as when you submitted the job

```
nvidia-smi
env | grep SLURM
module load pytorch
```

To end your interactive session (and prevent accrual of additional charges to your FCA), simply enter `exit` in the terminal session.

NOTE: you are charged for the entire node when running interactive jobs (as with batch jobs) except in the HTC and GPU (*_htc and *_gpu) partitions.

# Low-priority queue

Condo users have access to the broader compute resource that is limited only by the size of partitions, under the *savio_lowprio* QoS (queue). However this QoS does not get a priority as high as the general QoSs, such as *savio_normal* and *savio_debug*, or all the condo QoSs, and it is subject to preemption when all the other QoSs become busy.

More details can be found [in the *Low Priority Jobs* section of the user guide](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/running-your-jobs/submitting-jobs/#low-priority).

Suppose I wanted to burst beyond the Statistics condo to run on 20 nodes. I'll illustrate here with an interactive job though usually this would be for a batch job.


```
## First I'll see if there are that many nodes even available.
sinfo -p savio2
srun -A co_stat -p savio2 --qos=savio_lowprio --nodes=20 -t 10:00 --pty bash

## now look at environment variables to see my job can access 20 nodes:
env | grep SLURM
```

The low-priority queue is also quite useful for accessing specific GPU types in the `savio3_gpu` partition.


# Alternatives to the HTC partitions for collections of serial jobs

You may have many serial jobs to run. It may be more cost-effective to collect those jobs together and run them across multiple cores on one or more nodes.

Here are some options:

  - using [GNU parallel](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/running-your-jobs/gnu-parallel/) to run many computational tasks (e.g., thousands of simulations, scanning tens of thousands of parameter values, etc.) as part of single Savio job submission
  - using [single-node or multi-node parallelism](https://berkeley-scf.github.io/tutorial-parallelization) in Python, R, and MATLAB
    - parallel R tools such as *future*, *foreach*, *parLapply*, and *mclapply*
    - parallel Python tools such as  *ipyparallel*, *Dask*, and *ray*
    - parallel functionality in MATLAB through *parfor*

# Monitoring jobs, the job queue, and overall usage

The basic command for seeing what is running on the system is `squeue`:
```
squeue
squeue -u $USER
squeue -A co_stat
```

To see what nodes are available in a given partition:
```
sinfo -p savio4
sinfo -p savio3_gpu
```

You can cancel a job with `scancel`.
```
scancel <YOUR_JOB_ID>
```

For more information on cores, QoS, and additional (e.g., GPU) resources, here's some syntax:
```
squeue -o "%.7i %.12P %.20j %.8u %.2t %.9M %.5C %.8r %.3D %.20R %.8p %.20q %b"
```

We provide some [tips about monitoring your jobs](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/running-your-jobs/monitoring-jobs/).

If you'd like to see how much of an FCA has been used:

```
check_usage.sh -a fc_rail
```

# When will my job start?

The `sq` tool on Savio provides a bit more user-friendly way to understand why your job isn't running yet. Here's the basic usage:
```
# should be loaded by default, but if it isn't:
# module load sq
sq
```

```
Showing results for user paciorek
Currently 0 running jobs and 1 pending job (most recent job first):
+---------|------|-------------|-----------|--------------|------|---------|-----------+
| Job ID  | Name |   Account   |   Nodes   |     QOS      | Time |  State  |  Reason   |
+---------|------|-------------|-----------|--------------|------|---------|-----------+
| 7510375 | test | fc_paciorek | 1x savio2 | savio_normal | 0:00 | PENDING | Resources |
+---------|------|-------------|-----------|--------------|------|---------|-----------+

7510375:
This job is scheduled to run after 21 higher priority jobs.
    Estimated start time: N/A
    To get scheduled sooner, you can try reducing wall clock time as appropriate.

Recent jobs (most recent job first):
+---------|------|-------------|-----------|----------|---------------------|-----------+
| Job ID  | Name |   Account   |   Nodes   | Elapsed  |         End         |   State   |
+---------|------|-------------|-----------|----------|---------------------|-----------+
| 7509474 | test | fc_paciorek | 1x savio2 | 00:00:16 | 2021-02-09 23:47:45 | COMPLETED |
+---------|------|-------------|-----------|----------|---------------------|-----------+

7509474:
 - This job ran for a very short amount of time (0:00:16). You may want to check that the output was correct or if it exited because of a problem.
 ```

To see another user's jobs:

```
sq -u paciorek
```

The `-a` flag shows current and past jobs together, the `-q` flag suppresses messages about job issues, and the `-n` flag sets the limit on the number of jobs to show in the output (default = 8).

```
sq -u paciorek -aq -n 10
```

```
Showing results for user paciorek
Recent jobs (most recent job first):
+-----------|------|-------------|-----------|------------|---------------------|-----------+
|  Job ID   | Name |   Account   |   Nodes   |  Elapsed   |         End         |   State   |
+-----------|------|-------------|-----------|------------|---------------------|-----------+
| 7487633.1 | ray  |   co_stat   |    1x     | 1-20:19:03 |       Unknown       |  RUNNING  |
| 7487633.0 | ray  |   co_stat   |    1x     | 1-20:19:08 |       Unknown       |  RUNNING  |
|  7487633  | test |   co_stat   | 2x savio2 | 1-20:19:12 |       Unknown       |  RUNNING  |
|  7487879  | bash | ac_scsguest | 1x savio  |  00:00:27  | 2021-02-08 14:54:19 | COMPLETED |
| 7487633.2 | bash |   co_stat   |    2x     |  00:00:34  | 2021-02-08 14:53:38 |  FAILED   |
|  7487515  | test |   co_stat   | 2x savio2 |  00:04:53  | 2021-02-08 14:22:17 | CANCELLED |
| 7487515.1 | ray  |   co_stat   |    1x     |  00:00:06  | 2021-02-08 14:17:39 |  FAILED   |
| 7487515.0 | ray  |   co_stat   |    1x     |  00:00:05  | 2021-02-08 14:17:33 |  FAILED   |
|  7473988  | test |   co_stat   | 2x savio2 | 3-00:00:16 | 2021-02-08 13:33:40 |  TIMEOUT  |
|  7473989  | test | ac_scsguest | 2x savio  | 2-22:30:11 | 2021-02-08 11:47:54 | CANCELLED |
+-----------|------|-------------|-----------|------------|---------------------|-----------+
```

For help with `sq`:

```
sq -h
```

To learn more, see our page on understanding [when your jobs will run](https://docs-research-it.berkeley.edu/services/high-performance-computing/user-guide/running-your-jobs/why-job-not-run/).


# Another Way to Leverage Savio: Open OnDemand (OOD)

Savio has an Open OnDemand portal, a web-based way to access Savio using only your web browser.

Using OOD you can:

- View, download, and upload files on Savio
- View the status of your current jobs
- Start a shell session on Savio (i.e., terminal access)
- Launch Jupyter, RStudio, and VS Code servers or Matlab GUI
- Access a Linux desktop on Savio


# Jobs and shell access

You can also view a job or get shell access:

 - To view active jobs, click on "Jobs" and then "Active Jobs"
 - To get shell access, click on "Clusters" and then "BRC Shell Access"

# Submitting a job in OOD

To submit a job using only OOD:

1. Open the file browser
2. Upload or create/edit a job submission script
3. Open a shell session
4. Submit the job using sbatch

# Launching a Jupyter Session in OOD

To launch a Jupyter session:

 - Click on the "Interactive Apps" drop-down menu and select one of the Jupyter server options
   - The "compute on shared Jupyter node" option is for testing and debugging jobs
     - No service units charged, but minimal computing power
   - The "compute via Slurm" should be used for all other use cases
     - Service units are charged based on job run time (and resource(s) used)
 - Specify your Slurm options if relevant
   - SLURM QoS Name: "savio_normal" is generally recommended
 - Hit launch to start up a notebook


# IPyParallel


You can follow along with [this Jupyter notebook](https://github.com/ucb-rit/savio-training-intro-fall-2024/blob/main/Intro_to_Savio_iPP.ipynb).

We'll start up a Jupyter session that requests multiple cores.

Then in the notebook we first import IPyParallel and set up a cluster:

```python
import os

# Import the package
import ipyparallel as ipp

# Get number of cores (for one node)
n_workers = int(os.getenv('SLURM_CPUS_ON_NODE'))

# Create a remote cluster (It only takes one line!)
rc = ipp.Cluster(n=n_workers).start_and_connect_sync()
```

Note that `ipyparallel` is not installed in the `anaconda3` module used by the Jupyter app.
I installed it via `pip install --user ipyparallel`, or one could create a Jupyter kernel from a Conda environment.

Then create a *direct view*, which lets you run tasks across all the workers in a simple fashion:

```python
dview = rc[:]
```

There are two ways to import packages on the engines


```python
# Import via execute
dview.execute('import numpy as np')

# Import via sync_imports
with dview.sync_imports():
    import numpy as np
```

# IPyParallel: Basic Operations

The push command lets you send data to each worker (*engine*):

```python
# Send data to each worker
dview.push(dict(a=1.03234, b=3453))

# Manually to individual workers
for i in range(n_workers):
  rc[i].push({'num': rc.ids[i]})
```

Some commands will return an asynchronous object:

```python
# Apply and then get
async_object = dview.apply(lambda x: id+x, 27)
print(async_object)
# Get the result
async_object.get()
```

There are other ways to make sure your code finishes running before moving on

```python
# Can use apply sync
dview.apply_sync(lambda x: num+x, 27)

# Or use blocking for all operations
dview.block=True
dview.apply(lambda x: num+x, 27)
```


# IPyParallel: Load Balancing and Maps

A *load balanced* view assigns tasks to keep all of the workers busy:

```python
# Create a balanced load view
lview = rc.load_balanced_view()

# Cause execution on main process to wait while tasks sent to workers finish.
lview.block = True
```

To calculate $\pi$ by Monte Carlo simulation, let's define a function that checks if two points are in the unit circle. Each worker will process a large number of points in a vectorized fashion.

```python
def local_mean(seed):
  rng = np.random.default_rng(seed=seed)
  x = rng.uniform(size = 100000).reshape(-1,2)
  return np.mean(x[:,0]**2 + x[:,1]**2 < 1)
```

```python
# Execute map
m = 100
pi4 = lview.map(local_mean, range(m))   # Run calculation in parallel
# Estimate pi
print(np.mean(pi4) * 4)
```

# IPyParallel: summary

 - IPyParallel is one simple way to get going with easy to parallelize problems.
 - Blocking is important.
 - Using a load-balanced view will make the most of your resources.
 - IPyParallel can be used with multiple nodes (with more complexity).

# How to get additional help

 - Check the Status and Announcements page:
    - [https://research-it.berkeley.edu/services/high-performance-computing/status-and-announcements](https://research-it.berkeley.edu/services/high-performance-computing/status-and-announcements)
 - For technical issues and questions about using Savio:
    - brc-hpc-help@berkeley.edu
 - For questions about computing resources in general, including cloud computing:
    - brc@berkeley.edu
    - office hours: office hours: Wed. 1:30-3:00 and Thur. 9:30-11:00 [on Zoom](https://research-it.berkeley.edu/programs/berkeley-research-computing/research-computing-consulting)
 - For questions about data management (including HIPAA-protected data):
    - researchdata@berkeley.edu
    - office hours: office hours: Wed. 1:30-3:00 and Thur. 9:30-11:00 [on Zoom](https://research-it.berkeley.edu/programs/berkeley-research-computing/research-computing-consulting)
