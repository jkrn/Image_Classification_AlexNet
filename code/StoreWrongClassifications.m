clc;
clear all;
close all;

Results = load('Evaluations/CatResults.mat');
SourceFolder = 'C:\Users\Jens\UNI\LNOS\Game\data\CatTest\cat.';
TargetFolder = 'C:\Users\Jens\UNI\LNOS\Game\WrongClassifications\Cat\cat.';

numImages = length(Results.wrongClassifications);

for i = 1:1:numImages
    command = [ 'copy ',SourceFolder,num2str(Results.wrongClassifications(i)),'.jpg ',...
                TargetFolder,num2str(Results.wrongClassifications(i)),'.jpg'];
    system(command);
end;