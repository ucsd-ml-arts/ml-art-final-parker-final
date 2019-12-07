# Final Project

Your Name, yourcontact@ucsd.edu

(Your teammates' contact info, if appropriate)

## Abstract Proposal

FIRST STEP: Write up a description (in the form of an abstract) of what you will revisit for your final project. This should be one paragraph clearly describing your concept and approach. What are your desired creative goals? How are you expanding on something we covered in the class? How will you present your work next Wednesday in the final project presentations? 

## Project Report

Upload your project report (4 pages) as a pdf with your repository, following this template: [google docs](https://drive.google.com/open?id=1mgIxwX1VseLyeM9uPSv5GJQgRWNFqtBZ0GKE9d4Qxww).

## Model/Data

Briefly describe the files that are included with your repository:
- trained models
- training data (or link to training data)

## Code

Your code for generating your project:
- Python: generative_code.py
- Jupyter notebooks: generative_code.ipynb

## Results

Documentation of your results in an appropriate format, both links to files and a brief description of their contents:
- What you include here will very much depend on the format of your final project
  - image files (`.jpg`, `.png` or whatever else is appropriate)
  - 3d models
  - movie files (uploaded to youtube or vimeo due to github file size limits)
  - audio files
  - ... some other form

## Technical Notes

Any implementation details or notes we need to repeat your work. 
- Does this code require other pip packages, software, etc?
- Does it run on some other (non-datahub) platform? (CoLab, etc.)

## Reference

- Real Faces dataset: https://github.com/NVlabs/ffhq-dataset  
  Note that StyleGAN was trained on this.
- Fake Faces dataset: https://thispersondoesnotexist.com  
  Note that these were generated using StyleGAN
- Unpaired Image Translation: https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix


Interesting idea: if I were to use a StyleGAN encoder on my real faces dataset, then I could conceivably construct a *paired* dataset... I know that if the purpose is to translate to the output of the encoder-decoder, then training a paired image traslation would be redundant, but what if I throw something new (not a face) into that paired model?  Just a thought.
