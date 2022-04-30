#!/bin/bash
#SBATCH --account=def-wjwelch
#SBATCH --gres=gpu:a100:1
#SBATCH --cpus-per-task=2
#SBATCH --mem=64G
#SBATCH --time=1-00:00
#SBATCH --mail-user=xin.ding@stat.ubc.ca
#SBATCH --mail-type=ALL
#SBATCH --job-name=nI_SK_VA
#SBATCH --output=%x-%j.out


module load arch/avx2 StdEnv/2020
module load cuda/11.0
module load python/3.9.6
virtualenv --no-download ~/ENV
source ~/ENV/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r ./requirements.req

ROOT_PATH="/scratch/dingx92/cGAN-KD/ImageNet-100/SSKD"
DATA_PATH="/scratch/dingx92/datasets/ImageNet-100"


# ARCH="wrn_40_2"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="resnet110"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="vgg13"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="vgg19"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

ARCH="ResNet34"
python teacher.py \
    --root_path $ROOT_PATH --real_data $DATA_PATH \
    --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
    --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
    2>&1 | tee output_${ARCH}_vanilla.txt









# ARCH="resnet32x4"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="ResNet50"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="vgg13"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt


# ARCH="resnet56"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt


# ARCH="wrn_40_1"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="resnet20"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="vgg8"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="resnet8x4"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="MobileNetV2"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.01 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="ShuffleV1"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.01 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="ShuffleV2"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.01 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt

# ARCH="wrn_16_2"
# python teacher.py \
#     --root_path $ROOT_PATH --real_data $DATA_PATH \
#     --arch $ARCH --epochs 240 --resume_epoch 0 --save_interval 20 \
#     --batch_size 128 --lr 0.05 --lr_decay_epochs "150_180_210" --weight_decay 5e-4 \
#     2>&1 | tee output_${ARCH}_vanilla.txt