# Final Project

Parker Addison, pgaddiso@ucsd.edu

## Abstract Proposal

This project is a continuation of my work on [*face2fake*](https://github.com/ucsd-ml-arts/generative-visual-parker-visual).  The process and output have changed, but the background and motivation have remained the same.

In this project, real faces are transformed into uncanny, generated-looking faces.  Multiple methods of achieving this were attempted, including:
- Training CycleGAN [[6]] on high quality 1024x1024 images of real faces from the FFHQ repository [[7]] and 1024x1024 images of fake faces generated from ThisPersonDoesNotExist [[2]].
- Running Neural Style Transfer [[8]] using a single real face as the Content Image, and multiple fakes faces from [[2]] as the Style Images.
- Using StyleGAN-Encoder [[9]] to iterate towards a StyleGAN latent vector which generates output that minimizes perceptual loss with a single real face.

The StyleGAN-Encoder approach produced the best results, and this project demonstrates "GAN-ification" on the eight subjects used in the *face2fake* project: Barack Obama, Bill Clinton, Ivanka Trump, Nicolas Cage, Serena Williams, Jackie Chan, Parker Addison, and Robert Twomey.  

In addition to images of each individual subject as they are independently reconstructed using the encoder, this project also showcases a video in which the encoder attempted to find a latent representation of a given subject on the condition that the optimization seach had to start at the latent representation of the previously-reconstructed subject.

*Below is the original abstract from the *face2fake* project:*

> Within recent years, GAN technology has allowed people to generate convincing, yet fake humans faces with incredible speed. Advancements such as StyleGAN [[1]] have greatly bolstered the believability of these generated faces, prompting fake-face entertainment [[2]], fake-face business uses [[3]], and fake-face legal misuses [[4]]. However, with most of these models, the generated images are still not yet on par with what our brains (which have, presumably, seen human faces all our lives) have come to expect. Instead, the result is commonly referred to as uncanny. Looking at the generated image, the mind can tell that something just isn't right. Upon closer inspection, it may be that the teeth or melded together, or the eyes are slightly different shapes, or the skin has strange presence and/or absence of folds and stretch marks. At the end of the day, despite all of the wrongness that the brain sees in the image, there is still slight comfort to be found in the realization that these people don't actually exist.
>
> But what if they did? How would it feel to see yourself as the output of a GAN?
>
> The goal of this art piece is to deliver on those questions—to create a model which can take an image of a real face and embed within it the uncanniness of a fake generated face.


## Project Report

See `ECE188 Final.pdf`

## Model/Data

This project relies on multiple pre-trained models included in the StyleGAN [[1]] and StyleGAN-Encoder [[9]] repositories, respectively.  These pre-trained models are:
- StyleGAN from the official paper, *"A Style-Based Generator Architecture for Generative Adversarial Networks"*, trained on the FFHQ [[7]] data set
- VGG-16 from the official paper, *"Very Deep Convolutional Networks for Large-Scale Visual Recognition"*
- VGG-16 Zhang Perceptual derived by Richard Zhang, Phillip Isola, Alexei A. Efros, Eli Shechtman, and Oliver Wang.

The StyleGAN-Encoder approach needed no further data to train its latent reconstructions.

## Code

Simple usage of the StyleGAN-Encoder is as follows:

```bash
$ # Clone the StyleGAN-Encoder repository
$ git clone https://github.com/Puzer/stylegan-encoder
$
$ cd stylegan-encoder
$
$ # Add your desired real faces (they don't need to be cropped)
$ mkdir images/raw_images images/aligned_images images/generated_images images/latent_representations
$
$ cp ../people/* images/raw_images/
$ 
$ # Align the images
$ python align_images.py images/raw_images images/aligned_images
$ 
$ # Produce your reconstructions with your desired number of iterations
$ python encode_images.py images/aligned_images images/generated_images images/latent_representations --iterations <iter-count>
```

I had to slightly modify `encode_images.py` and `encoder/perceptual_model.py` in order to:
- optionally generate an image after every 10 epochs, instead of only at the end of all epochs
- optionally begin the optimization search at a given latent representation as opposed to the null vector

These modified scripts have been included.  I had the intention of adding the following arguments when calling `python encode_images.py`:
- `--generate-every <int>` (default `None`) Generates the reconstructed image after every N epochs in addition to at the end of all epochs.
- `--dependent-start` If present, does not reset the latent-vector between target reconstructions.
- `--start-at <path-to-.npy>` The path to the latent representation to start the first target reconstruction at.

However, I had issues with some of these arguments, so currently none of the arguments exist—instead they are just hardcoded into the scripts!  Since I would like to come back to this project later, I may end up polishing these up.

Also provided is a script `video.sh` which converts the above generated frames into an mp4 clip.

## Results

See [`index.html`]()

See `images/generated_images/*ep/<person-name>.mp4` for StyleGAN reconstruction of a subject, starting from the null latent vector.

See `images/generated_images/loop/loop.mp4` for a loop-able clip of StyleGAN reconstruction of a subject, starting from the learned latent vector of the previous subject.  Note that these reconstructions struggled to achieve the same loss minimization as the reconstructions which started at the null latent vector, however the same number of reconstruction iterations is used.

See `images/generated_images/loop/<person-name>.mp4` to see the individual subject reconstructions from the loopable clip.

All of the above mentioned video clips have a frame for every 10 iterations of the StyleGAN-Encoder [[8]], up to 1440 iterations per subject.

## Technical Notes

See `conda_requirements.txt` for Python packages that are required.

Note that the command-line tool `ffmpeg` is required to convert the images to videos.

## Reference

1. Tero Karras, Samuli Laine, Timo Aila, and Nvidia. *A Style-Based Generator Architecture for Generative Adversarial Networks*. December 2018. https://github.com/NVlabs/stylegan

[1]: https://github.com/NVlabs/stylegan

2. Phillip Wang. *This Person Does Not Exist*. February 2019. https://thispersondoesnotexist.com

[2]: https://thispersondoesnotexist.com

3. Ivan Braun et al. and Generated Media Inc. *100K Faces project*. https://generated.photos

[3]: https://generated.photos

4. AP News. *"Experts: Spy used AI-generated face to connect with targets"*. June 2019. https://apnews.com/bc2f19097a4c4fffaa00de6770b8a60d

[4]: https://apnews.com/bc2f19097a4c4fffaa00de6770b8a60d

5. Gary B. Huang, Manu Ramesh, Tamara Berg, Erik Learned-Miller. *Labeled Faces in the Wild: A Database for Studying Face Recognition in Unconstrained Environments*. University of Massachusetts. October 2007. http://vis-www.cs.umass.edu/lfw/

[5]: http://vis-www.cs.umass.edu/lfw/

6. Jun-Yan Zhu*, Taesung Park*, Phillip Isola, Alexei A. Efros. *Unpaired Image-to-Image Translation using Cycle-Consistent Adversarial Networks*. November 2017. https://junyanz.github.io/CycleGAN/

[6]: https://junyanz.github.io/CycleGAN/

7. Tero Karras, Samuli Laine, Timo Aila, and Nvidia. Flickr Faces High Quality dataset.  February 2019. https://github.com/NVlabs/ffhq-dataset

[7]: https://github.com/NVlabs/ffhq-dataset

8. Cameron Smith. *Neural Style Transfer*. November 2016. https://github.com/cysmith/neural-style-tf

[8]: https://github.com/cysmith/neural-style-tf

9. Dmitry Nikitko. StyleGAN-Encoder. February 2019. https://github.com/Puzer/stylegan-encoder

[9]: https://github.com/Puzer/stylegan-encoder
