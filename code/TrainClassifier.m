clc;
clear all;
close all;

showEvaluationResults = false;

% Load MatConvNet network into a SeriesNetwork
cnnFullMatFile = 'imagenet-caffe-alex.mat';
convnet = helperImportMatConvNet(cnnFullMatFile);

% Set up image data
dataFolder = 'data';
categories = {'Cat', 'Dog', 'Human', 'Fish'};
imds = imageDatastore(fullfile(dataFolder, categories), 'LabelSource', 'foldernames');
tbl = countEachLabel(imds);

% Use the smallest overlap set
minSetCount = min(tbl{:,2});

% Use splitEachLabel method to trim the set.
imds = splitEachLabel(imds, minSetCount, 'randomize');

% Notice that each set now has exactly the same number of images.
ImagesPerLabel = countEachLabel(imds);

% Set read function
imds.ReadFcn = @(filename)readAndPreprocessImage(filename);

if showEvaluationResults
    
    % Divide data into training and testing sets
    [trainingSet, testSet] = splitEachLabel(imds, 0.7, 'randomize');
    
else
    
    trainingSet = imds;
    
end;

% Get features
featureLayer = 'fc7';
trainingFeatures = activations(convnet, trainingSet, featureLayer, 'MiniBatchSize', 32, 'OutputAs', 'columns');

% Train a multiclass SVM classifier
% Get training labels from the trainingSet
trainingLabels = trainingSet.Labels;

% Train multiclass SVM classifier using a fast linear solver, and set
% 'ObservationsIn' to 'columns' to match the arrangement used for training
% features.
classifier = fitcecoc(trainingFeatures, trainingLabels, 'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');

if showEvaluationResults

    % Evaluate classifier
    % Extract test features using the CNN
    testFeatures = activations(convnet, testSet, featureLayer, 'MiniBatchSize',32);

    % Pass CNN image features to trained classifier
    predictedLabels = predict(classifier, testFeatures);

    % Get the known labels
    testLabels = testSet.Labels;

    % Tabulate the results using a confusion matrix.
    confMat = confusionmat(testLabels, predictedLabels);

    % Convert confusion matrix into percentage form
    confMat = bsxfun(@rdivide,confMat,sum(confMat,2))
    
else
    
    save('TrainedClassifer','categories','classifier','cnnFullMatFile','convnet','dataFolder','featureLayer','ImagesPerLabel','imds','minSetCount','tbl','trainingFeatures','trainingLabels');
    
end;