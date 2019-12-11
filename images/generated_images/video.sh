title=$1
dir=$2

ffmpeg -r 24 -f image2 -s 1024x1024 -i $dir$title/$title\_01_%*.png -vcodec libx264 -crf 25 -pix_fmt yuv420p $dir$title.mp4

