# Create variables for data and checkpoints directories
export DATADIR=/storage/face2fake/datasets
export CHECKDIR=/storage/face2fake/checkpoints

# Clone CycleGAN repository and install requirements
git clone https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix.git
cd pytorch-CycleGAN-and-pix2pix/

pip install -r requirements.txt

# Start training the model (assumes 2 GPUs)
python train.py --dataroot $DATADIR \
                --name face2fake \
                --gpu-ids 0,1 \
                --checkpoints_dir $CHECKDIR \
                --model cycle_gan \
                --batch_size 8 \
                --load_size 1024 \
                --crop_size 1024 \
                --preprocess none
