%NEEDS TO BE ABSOLUTE FILE PATH
%data_directory = 'ABSOLUTE_FILE_PATH/training_test_data';
%code_directory = 'ABSOLUTE_FILE_PATH/';
%training_directory = 'ABSOLUTE_FILE_PATH/training_test_data';

currentFolder = pwd;
code_directory = currentFolder;
training_directory = currentFolder;
cd 'training_test_data'
currentFolder = pwd;
data_directory = pwd;
cd '..'