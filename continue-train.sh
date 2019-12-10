# Create variables for data and checkpoints directories
export DATADIR=/storage/face2fake/datasets
export CHECKDIR=/storage/face2fake/checkpoints

# Clone CycleGAN repository and install requirements
git clone https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix.git
cd pytorch-CycleGAN-and-pix2pix/

pip install -r requirements.txt

# Start training the model
python train.py --dataroot $DATADIR \
                --name face2fake \
                --checkpoints_dir $CHECKDIR \
                --model cycle_gan \
                --display_id 0 \
                --gpu_ids $GPUIDS \
                --batch_size $BATCHSIZE \
                --load_size $LOADSIZE \
                --crop_size $CROPSIZE \
                --preprocess $PREPROCESS \
                --continue_train \
                --epoch_count $EPOCHCOUNT
