clc;
clearvars;
close all;

% VARIABLES
sourceFolder = 'C:\Users\Jens\Desktop\human';
newNamesFile = 'C:\Users\Jens\Desktop\HumanTest.csv';
prefixName = 'human.';

% --- read new names from file ---
[newNames, ~, ~] = xlsread(newNamesFile);
newNames = newNames';

% --- get file names in folder ---
sourceFiles = dir(sourceFolder);
numOldNames = size(sourceFiles,1);
oldNamesFull = [];
for i=1:1:numOldNames
    oldNamesFull{i} = sourceFiles(i).name;
end;
oldNamesFull{1} = [];
oldNamesFull{2} = [];
oldNames = oldNamesFull(~cellfun(@isempty,oldNamesFull));
numOldNames = numOldNames - 2;
clear oldNamesFull;
clear sourceFiles;
% --- rename files ---
for i=1:1:numOldNames
    oldNameParts = strsplit(oldNames{i},'.');
    com = ['ren "',sourceFolder,'\',oldNames{i},'" "',prefixName,num2str(newNames(i)),'.',oldNameParts{2},'"'];
    disp(com);
    system(com);
end;
disp('### DONE ###');