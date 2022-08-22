clc;
clear all;
close all;

classIDs = [1:4];
imgPaths = {'data/CatTest/cat.','data/DogTest/dog.','data/FishTest/fish.','data/HumanTest/human.'};
classifier = load('TrainedClassifer');
wrongClassifications = [0,0,0,0];
rightClassifications = [0,0,0,0];

n1 = 10000;
n2 = 10999;
nSpace = n1:1:n2;
sizeNSpace = length(nSpace);

for currClassID = classIDs
    for i=nSpace
        imgName = [imgPaths{currClassID},num2str(i),'.jpg'];
        img = readAndPreprocessImage(imgName);
        
        imageFeatures = activations(classifier.convnet, img, classifier.featureLayer);
        MachineLabel = predict(classifier.classifier, imageFeatures);
        
        if MachineLabel == classifier.classifier.ClassNames(currClassID)
            rightClassifications(currClassID) = rightClassifications(currClassID) + 1;
        else
            wrongClassifications(currClassID) = wrongClassifications(currClassID) + 1;
        end;
        
        if mod(i,20) == 0
            disp(['classID = ',num2str(currClassID),' | i = ',num2str(i)]);
        end;
        
    end;
end;

Error = (wrongClassifications / sizeNSpace) * 100;
TotalError = ( sum(wrongClassifications) / (4*sizeNSpace) ) * 100;

disp(['Images per Class: ',num2str(sizeNSpace)]);
disp(['================================']);
disp(['RIGHT: ',num2str(rightClassifications)]);
disp(['WRONG: ',num2str(wrongClassifications)]);
disp(['ERROR (%): ',num2str(Error)]);
disp(['================================']);
disp(['TOTAL RIGHT: ',num2str(sum(rightClassifications))]);
disp(['TOTAL WRONG: ',num2str(sum(wrongClassifications))]);
disp(['TOTAL ERROR (%): ',num2str(TotalError)]);