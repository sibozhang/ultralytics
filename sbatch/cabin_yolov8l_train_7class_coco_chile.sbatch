#!/bin/bash
#SBATCH --partition=A100x8_twodays,A100x8,V100x8_sixdays,V100x8,V100_DGX
#SBATCH --gres=gpu:8
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --output=/mnt/scratch/sibo/ultralytics/logs/slurm/yolov8l_coco_2class_%j.out
#SBATCH --error=/mnt/scratch/sibo/ultralytics/logs/cabin/yolov8l_coco_2class_%j.err
#SBATCH --exclude=asimov-246

cd /mnt/scratch/sibo/ultralytics
source /tools/anaconda3-default/etc/profile.d/conda.sh
conda activate yolov8

srun yolo detect train data=/mnt/scratch/sibo/ultralytics/ultralytics/cfg/datasets/coco_chile_cabin.yaml model=yolov8l.pt epochs=50 imgsz=640 device=0,1,2,3,4,5,6,7

# srun yolo detect train data=/mnt/scratch/sibo/ultralytics/ultralytics/cfg/datasets/coco_chile_7class.yaml model=/mnt/scratch/sibo/ultralytics/runs/detect/train49/weights/last.pt epochs=100 imgsz=640 device=0,1,2,3,4,5,6,7 patience=10
