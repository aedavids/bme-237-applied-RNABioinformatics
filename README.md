# Using Hummingbird

## Connecting
- use cisco anyConnect to access ucsc vpn
- use ssh hb. see ~/.ssh/config

[getting started with hummingbird](https://www.hb.ucsc.edu/getting-started/) see section about modules

Useful commands
```
$ module list
$ module avail

# load will modify your PATH. You need to run load every time you login
$ module load hisat/hisat2-2.1.0

export HISAT2_HOME=/hb/software/apps/hisat2/gnu-2.1.0
```

## set up an interactive session on hb using SLURM
weak interactive session. You can not do an big or long running jobs
- ref: search for "Job Allocation – Interactive, Serial" in [getting started with hummingbird](https://www.hb.ucsc.edu/getting-started/) see section about modules

1) connect to humming bird
```
ssh hb
```

2) Request a node resource to execute your interactive program
```
salloc --partition=Instruction --nodes=1 --time=04:00:00 --mem=500M --cpus-per-task=1
salloc: Granted job allocation 94986

# verify
[aedavids@hb ~]$ export | grep SLURM
declare -x SLURM_CLUSTER_NAME="hbhpc"
declare -x SLURM_CPUS_PER_TASK="1"
declare -x SLURM_JOBID="94986"
declare -x SLURM_JOB_CPUS_PER_NODE="1"
declare -x SLURM_JOB_ID="94986"
declare -x SLURM_JOB_NAME="bash"
declare -x SLURM_JOB_NODELIST="hbcomp-005"
declare -x SLURM_JOB_NUM_NODES="1"
declare -x SLURM_JOB_PARTITION="Instruction"
declare -x SLURM_JOB_QOS="normal"
declare -x SLURM_MEM_PER_NODE="500"
declare -x SLURM_NNODES="1"
declare -x SLURM_NODELIST="hbcomp-005"
declare -x SLURM_NODE_ALIASES="(null)"
declare -x SLURM_SUBMIT_DIR="/hb/home/aedavids"
declare -x SLURM_SUBMIT_HOST="hb"
declare -x SLURM_TASKS_PER_NODE="1"
```

3) log on to allocated node
```
 ssh $SLURM_NODELIST
```

4) when you are done make sure you use exit to leave slurm interactive shell
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTcyNTE2NDIyNV19
-->