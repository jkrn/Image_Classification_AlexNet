clc;
clearvars;
close all;

% VARIABLES
currClassID = 4;
imgPath = 'data/HumanTest/human.';
saveFileName = 'HumanResults';

% CONSTANTS
classifier = load('TrainedClassifer');
wrongClassifications = [];
rightClassifications = [];
saveFileNameRight = 'Right.txt';
saveFileNameWrong = 'Wrong.txt';

for i = 10000:1:12499

    imgName = [imgPath,num2str(i),'.jpg'];
    img = readAndPreprocessImage(imgName);

    imageFeatures = activations(classifier.convnet, img, classifier.featureLayer);
    MachineLabel = predict(classifier.classifier, imageFeatures);

    if MachineLabel == classifier.classifier.ClassNames(currClassID)
        rightClassifications = [rightClassifications;i];
    else
        wrongClassifications = [wrongClassifications;i];
    end;
    
    if mod(i,20) == 0
        disp(['i = ',num2str(i)]);
    end;

end;

disp(['RIGHT: ',num2str(length(rightClassifications))]);
disp(['WRONG: ',num2str(length(wrongClassifications))]);

save(saveFileName,'rightClassifications','wrongClassifications');

% RIGHT
fileID = fopen([saveFileName,saveFileNameRight],'w');
for j = 1:1:length(rightClassifications)
    fprintf(fileID,[num2str(rightClassifications(j)),'\n']);
end;
fclose(fileID);
% WRONG
fileID = fopen([saveFileName,saveFileNameWrong],'w');
for j = 1:1:length(wrongClassifications)
    fprintf(fileID,[num2str(wrongClassifications(j)),'\n']);
end;
fclose(fileID);