#!/bin/bash
# Run script recon_all_BIDS_long, which uses FreeSurfer's recon_all on a longitudinal cohort of patients.
#SBATCH -J free
#SBATCH -p high
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --workdir=/homedtic/gmarti
#SBATCH -o LOGS/free_%J.out # STDOUT
#SBATCH -e LOGS/free_%j.err # STDERR

module load MATLAB
module load libGLU
# Activate custom environment
export PATH="$HOME/project/anaconda3/bin:$PATH"
source activate dlnn
# Activate freesurfer paths
FSLDIR=/homedtic/gmarti/LIB/fsl
. ${FSLDIR}/etc/fslconf/fsl.sh
export PATH=${FSLDIR}/bin:${PATH}
export PATH="~/.local/bin:$PATH"
export PATH="~/bin:$PATH"
export FREESURFER_HOME=/homedtic/gmarti/LIB/freesurfer
. $FREESURFER_HOME/SetUpFreeSurfer.sh
SECONDS=0

python /homedtic/gmarti/CODE/upf-nii/scripts/recon_all_BIDS.py --in_dir /homedtic/gmarti/DATA/Data/ADNI_BIDS --img_suffix .nii.gz --output_path /homedtic/gmarti/DATA/Data/SIMLR-AD-FS_Full/ --subject_file /homedtic/gmarti/DATA/ADNImetadata/simlrad-paper/freesurfer_information_v2.csv --number_jobs 40

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
