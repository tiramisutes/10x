#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --mem=200G
#SBATCH --time=40:00:00
#SBATCH --output=longranger_basic.sh.stdout
#SBATCH -p intel
#SBATCH --workdir=./

#sbatch --array 1 run_speedseq_qsub.sh

export PATH="/rhome/cjinfeng/BigData/00.RD/Assembly/10xgenomics/tools/arcs/bin:/rhome/cjinfeng/BigData/00.RD/Assembly/10xgenomics/tools/longranger/longranger-2.1.3:$PATH"

start=`date +%s`

CPU=$SLURM_NTASKS
if [ ! $CPU ]; then
   CPU=2
fi

N=$SLURM_ARRAY_TASK_ID
if [ ! $N ]; then
    N=1
fi

echo "CPU: $CPU"
echo "N: $N"


#longranger basic will generate fastq file with barcode in header
#zcat testrun/outs/barcoded.fastq.gz | less -S 
ID=testrun1
fastq=./fastq
longranger basic --id=$ID --fastqs=$fastq \
     --bam \
     --localmem=128 \
     --localcores=24

end=`date +%s`
runtime=$((end-start))

echo "Start: $start"
echo "End: $end"
echo "Run time: $runtime"

echo "Done"
