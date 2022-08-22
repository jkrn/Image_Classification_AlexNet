clc;
clearvars;
close all;

% Set up main window
w = Window;
setLanguage(w,1); % English
%setLanguage(w,0); % German
set(w, 'KeyPressFcn', @(fig_obj , eventDat) keyboardListener(fig_obj, eventDat, w));

% Set to fullscreen
jFig = get(handle(w), 'JavaFrame'); 
set(jFig,'Maximized',1);