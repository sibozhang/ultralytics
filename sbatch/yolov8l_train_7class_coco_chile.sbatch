#!/bin/bash
#SBATCH --partition=V100x8_sixdays,V100x8,A100x8_twodays,A100x8,V100_DGX
#SBATCH --gres=gpu:8
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --output=/mnt/scratch/sibo/ultralytics/logs/slurm/yolov8l_coco_chile_7class_%j.out
#SBATCH --error=/mnt/scratch/sibo/ultralytics/logs/outdoor/yolov8l_coco_chile_7class_%j.err
#SBATCH --exclude=asimov-246

cd /mnt/scratch/sibo/ultralytics
source /tools/anaconda3-default/etc/profile.d/conda.sh
conda activate yolov8

# srun yolo train resume model=/mnt/scratch/sibo/ultralytics/runs/detect/train52/weights/last.pt
srun yolo detect train data=/mnt/scratch/sibo/ultralytics/ultralytics/cfg/datasets/coco_chile_7class.yaml model=yolov8l.pt epochs=150 imgsz=640 device=0,1,2,3,4,5,6,7
