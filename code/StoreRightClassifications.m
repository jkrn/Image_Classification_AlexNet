clc;
clear all;
close all;

Results = load('Evaluations/HumanResults.mat');
SourceFolder = 'C:\Users\Jens\UNI\LNOS\Game\data\HumanTest\human.';
TargetFolder = 'C:\Users\Jens\UNI\LNOS\Game\RightClassifications\Human\human.';

numImages = length(Results.rightClassifications);

for i = 1:1:numImages
    command = [ 'copy ',SourceFolder,num2str(Results.rightClassifications(i)),'.jpg ',...
                TargetFolder,num2str(Results.rightClassifications(i)),'.jpg'];
    system(command);
end;