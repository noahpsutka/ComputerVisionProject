# ComputerVisionProject

### Contributors: Michael Gonzales, Ben Prentice, Noah Psutka

## Task

Implement a face detector that is trained using AdaBoost, combines information from skin color and rectangle filters, and utilizes the ideas of bootstrapping and classifier cascades. In particular, the following methods/concepts must be utilized in this face detector:

- **AdaBoost**: The face detector, or at least components of the face detector, must be trained using AdaBoost and rectangle filters.
- **Skin detection**: A skin detector must be used to improve the efficiency of face detection on color images.
- **Bootstrapping**: Bootstrapping is a method for improving the quality of the training set by identifying and including more challenging examples. Bootstrapping is performed by iterating between 1). Training a face detector using a subset of the training set, and 2). Applying the face detector on additional data and adding to the training set cases where the face detector makes mistakes.
- **Classifier cascades**: An AdaBoost-based detector was implemented in the code available online for this course. In that detector, the same strong classifier was applied to every single window of the image. A classifier cascade is a sequence of classifiers, where the first classifier is very fast but relatively inaccurate, and each subsequent classifier is slower but more accurate. For every classifier in the cascade (except for the final classifier), we need to choose a threshold that determines whether a window should be classified as nonface, or should be passed on to the next classifier in the cascade. That threshold should be chosen so that it causes as few mistakes as possible.

## Data

All the data that you need for this project can be in the attached file training_test_data.zip. When you train your system, you can use windows from images in the directory training_faces as positive examples. As negative examples, you can use windows from images in the directory training_nonfaces. For bootstrapping, once you have trained a detector, you should apply it to all images in training_faces and training_nonfaces, identify windows where the detector makes mistakes, add those windows to the training set, and retrain.

As test data, you can use the images in directories test_cropped_faces, test_face_photos, and test_nonfaces. You are not allowed to use any of these test data for training.

## Submission Instructions

You should submit your project on Canvas (not on Matlab Grader). You should submit all your code and also whatever data was computed and saved by your training algorithm. Do not submit any training and test images, you can assume that we have the entire training_test_data directory on our computer.

- You should have a script in a file called train.m, so that if we type "train" from Matlab, it performs the entire training sequence (it is OK if it takes hours).
- You should have a script called test.m, so that if we type "test" then your face detector (the best, final version of your face detector) is applied to all test images, and it reports numbers of false positives and false negatives (for some threshold that you have chosen in advance).
- You should save the results of your training (and submit them with the rest of the project), so that the "test" script just loads those results and then starts applying the face detector on test images. The idea is that we should be able to run the test script even if we have not run the training script.
- You should have a file called directories.m that sets the location of the:
  - directory training_test_data
  - base directory of your code
  - directory where you save the results of training.
  - This file should only contain three lines, that set three variables, data_directory, code_directory, and training_directory, as follows:

data_directory = 'fill in appropriately';

code_directory = 'fill in appopriately';

training_directory = 'fill in appopriately';

- The only file that we should need to modify, in order to run your code, should be the directories.m file. Points will be taken off if we need to make more modifications. You should assume that, somewhere on our computer, we have the training_test_data directory, your code, and your results of training. Once we specify where those three locations are in your directories.m file, everything else should run.
- You must include a report, in PDF format. This report is SEPARATE from the slides you will use for your oral presentation of the project (although, of course, the two documents can share tables, figures, or any other text). The project report should describe in an easy-to-read way:
  - the key implementation choices that you had to make in your algorithm, and a solid justification for each choice.
  - for every single hard-coded parameter that you used, justify why that parameter needed to be used, and provide the value that you used for that parameter.
  - the results of experimental evaluation: report the accuracy and efficiency of the detector, and how each of the components (basic AdaBoost bootstrapping, cascades) affects performance.
Someone should be able to replicate your results based on your report. For the results, make sure you clearly define how you measure accuracy, and over what set (or sets) you measure it.

## Grading

Grading will be based on how well you applied the knowledge that you obtained in this course in order to design a detector that is accurate and efficient. 20% of the project grade will be assigned to each of the four components of the system (AdaBoost, skin detection, bootstrapping, cascades).

In addition to the correctness and quality of implementation, you will also be graded based on:

- the quality of the decisions and choices you make in building your system.
- the quality and information content of the experimental evaluation.
- the quality of the written project report (is it informative? does it allow duplicating the results? is it easy to read?)
In general, this project is intended to be a simulation of a project that you could be assigned when working in the real world. In such projects, much less is specified than in a typical homework assignment; the system designer needs to evaluate different choices at each step, and finally make choices that lead to a good product/system. Also, the system designer must be able to explain what was done, justify different choices, and describe clearly how well each component works. During this course, you have learned a variety of different computer vision methods, and you have also encountered several different approaches for making system design choices and for justifying those choices. This is an opportunity to use what you have learned.
