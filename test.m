testPhotos = [data_directory, '/', 'test_face_photos'];
load boostedVariables.mat;

%% TEST FOR ADABOOST CORRECTNESS

failed_predicts_plus = 0;
failed_predicts_neg = 0;

for index = 1:3049
     prediction_plus = boosted_predict(cropped_faces(:, :, index), boosted_classifier, weak_classifiers, 15);
     prediction_neg = boosted_predict(nonfaces(:, :, index), boosted_classifier, weak_classifiers, 15);

     if(prediction_plus<0)
        failed_predicts_plus = 1 + failed_predicts_plus;
     end
     if(prediction_neg>0)
        failed_predicts_neg = 1 + failed_predicts_neg;
     end
end


for index = 1:7655
     prediction_neg = boosted_predict(nonfaces(:, :, index), boosted_classifier, weak_classifiers, 15);

     if (prediction_neg>0)
        failed_predicts_neg = 1 + failed_predicts_neg;
     end
end
%% CLASSIFIER ERROR RATE
temp = string(failed_predicts_plus/3049);
incorrect_p =strcat('Incorrectly classified face images:' , temp , "%");
disp(incorrect_p);

temp = string(failed_predicts_neg/7655);
incorrect_n =strcat('Incorrectly classified nonface images:' ,temp, "%");
disp(incorrect_n);

%% TEST ADABOOST WITHOUT SKIN DETECTION ONE SCALE
% folder = convertCharsToStrings(testPhotos);
folder = 'training_test_data/test_face_photos';
allphotos = fullfile(folder, '*.jpg');
photos = dir(allphotos);
for k = 1:length(photos)
  baseFileName = photos(k).name;
  fullFileName = fullfile(folder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  photo = read_gray(fullFileName);
  photo2 = imresize(photo, 0.5, 'bilinear');
  tic; [result, boxes] = boosted_detector_demo(photo2,.5, boosted_classifier, weak_classifiers, [59, 62], 4); toc
  figure(); imshow(result,[]); title(baseFileName);
end

%% TEST ADABOOST WITHOUT SKIN DETECTION MULTISCALE
% folder = convertCharsToStrings(testPhotos);
folder = 'training_test_data/test_face_photos';
allphotos = fullfile(folder, '*.jpg');
photos = dir(allphotos);
for k = 1:length(photos)
  baseFileName = photos(k).name;
  fullFileName = fullfile(folder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  photo = read_gray(fullFileName);
  photo2 = imresize(photo, 0.5, 'bilinear');
  tempScale = .5:0.1:4; 
  tic; [result, boxes] = boosted_detector_demo(photo2,tempScale, boosted_classifier, weak_classifiers, [59, 62], 4); toc
  figure(); imshow(result,[]); title(baseFileName);
end

%% TEST ADABOOST FACE DETECTOR WITH SKIN DETECTION

folder = 'training_test_data/test_face_photos';
allphotos = fullfile(folder, '*.jpg');
photos = dir(allphotos);
for k = 1:length(photos)
  baseFileName = photos(k).name;
  fullFileName = fullfile(folder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  photo = read_gray(fullFileName);
  
  skin_photo = imread(fullFileName);
  skin = skin_integral(skin_photo);


  skin_neighborhood = ones(7, 7);
  skin = imopen(skin, skin_neighborhood);
  skin_neighborhood2 = strel('disk', 11);
  skin = imdilate(skin, skin_neighborhood2);
  
  maskedPhoto = photo .* (1 - skin);
 
  photo = photo .* skin;

  photo = maskedPhoto + photo;

% photo2 = imrotate(photo, -10, 'bilinear');
  photo2 = imresize(photo, 0.5, 'bilinear');
  tempScale = .5:0.1:3; 
  tic; [result, boxes] = boosted_detector_demo(photo2,tempScale, boosted_classifier, weak_classifiers, [59, 62], 4); toc
  figure(); imshow(result,[]); title(baseFileName);
end