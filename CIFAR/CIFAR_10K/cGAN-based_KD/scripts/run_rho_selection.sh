ROOT_PATH="./CIFAR/CIFAR_10K/cGAN-based_KD"

SEED=2020
NUM_CLASSES=10
NTRAIN=10000

## for real+fake
FAKE_DATASET_NAME="BigGAN_vanilla_epochs_2000_transform_True_subsampling_True_FilterCEPct_0.7_nfake_349999" ## Format: GANNAME_..._nfake_xxx; Strings between GAN name and nfake value.; do not include seed
CNN_EPOCHS=350
LR_BASE=0.1
LR_DECAY_EPOCHS="150_250"
SAVE_FREQ="150_250"
NFAKE=100000
WD=1e-4


CNN_NAME="ShuffleNet"
echo "-------------------------------------------------------------------------------------------------"
echo "Baseline ${CNN_NAME}"
CUDA_VISIBLE_DEVICES=0 python3 baseline_cnn.py \
--root_path $ROOT_PATH --fake_dataset_name $FAKE_DATASET_NAME \
--cnn_name $CNN_NAME --seed $SEED \
--ntrain $NTRAIN --nfake $NFAKE --num_classes $NUM_CLASSES \
--epochs $CNN_EPOCHS --resume_epoch 0 --save_freq $SAVE_FREQ --batch_size_train 128 --lr_base 0.1 --lr_decay_factor 0.1 --lr_decay_epochs $LR_DECAY_EPOCHS --weight_decay 1e-4 --transform \
--validaiton_mode \
2>&1 | tee output_baseline_${CNN_NAME}_real_ntrain_${NTRAIN}_fake_nfake_${NFAKE}_subsampling_${SUBSAMPLE_FAKE}_filtering_${FILTER_FAKE}_seed_${SEED}.txt

CNN_NAME="efficientnet-b0"
echo "-------------------------------------------------------------------------------------------------"
echo "Baseline ${CNN_NAME}"
CUDA_VISIBLE_DEVICES=0 python3 baseline_cnn.py \
--root_path $ROOT_PATH --fake_dataset_name $FAKE_DATASET_NAME \
--cnn_name $CNN_NAME --seed $SEED \
--ntrain $NTRAIN --nfake $NFAKE --num_classes $NUM_CLASSES \
--epochs $CNN_EPOCHS --resume_epoch 0 --save_freq $SAVE_FREQ --batch_size_train 128 --lr_base 0.1 --lr_decay_factor 0.1 --lr_decay_epochs $LR_DECAY_EPOCHS --weight_decay 1e-4 --transform \
--validaiton_mode \
2>&1 | tee output_baseline_${CNN_NAME}_real_ntrain_${NTRAIN}_fake_nfake_${NFAKE}_subsampling_${SUBSAMPLE_FAKE}_filtering_${FILTER_FAKE}_seed_${SEED}.txt

CNN_NAME="VGG11"
echo "-------------------------------------------------------------------------------------------------"
echo "Baseline ${CNN_NAME}"
CUDA_VISIBLE_DEVICES=0 python3 baseline_cnn.py \
--root_path $ROOT_PATH --fake_dataset_name $FAKE_DATASET_NAME \
--cnn_name $CNN_NAME --seed $SEED \
--ntrain $NTRAIN --nfake $NFAKE --num_classes $NUM_CLASSES \
--epochs $CNN_EPOCHS --resume_epoch 0 --save_freq $SAVE_FREQ --batch_size_train 128 --lr_base 0.1 --lr_decay_factor 0.1 --lr_decay_epochs $LR_DECAY_EPOCHS --weight_decay 1e-4 --transform \
--validaiton_mode \
2>&1 | tee output_baseline_${CNN_NAME}_real_ntrain_${NTRAIN}_fake_nfake_${NFAKE}_subsampling_${SUBSAMPLE_FAKE}_filtering_${FILTER_FAKE}_seed_${SEED}.txt