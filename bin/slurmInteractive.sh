# start and interactive shell on a cluster node
# https://hummingbird.ucsc.edu/
# Job Allocation – Interactive, Serial https://hummingbird.ucsc.edu/getting-started/

echo ERROR script does not work. Need to use alias
set -x
salloc --partition=Instruction --nodes=1 --time=04:00:00 --mem=500M --cpus-per-task=1
ssh $SLURM_NODELIST
