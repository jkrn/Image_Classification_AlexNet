function showGame(data)
    %data = w.UserData;
    % --- Hide image ---
    background = imread('guiImages/black.png');
    imshow(background,'Parent',data.panelAxes);
    % --- Hide High Score Table ---
    set(data.highScoreNameText0,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText1,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText2,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText3,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText4,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText5,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText6,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText0,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText1,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText2,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText3,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText4,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText5,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText6,'Visible','off','string','','Foregroundcolor',[0 0 0]);
    % set Human / Machine text
    if data.englishLanguage == 1
        set(data.humanTextPanel,'string','Human');
        set(data.machineTextPanel,'string','Machine');
    else 
        set(data.humanTextPanel,'string','Mensch');
        set(data.machineTextPanel,'string','Maschine');
    end;
    % set counter text
    set(data.counter,'string','');
    % Status
    set(data.humanAnswer,'Visible','on');
    set(data.machineAnswer,'Visible','on');
    set(data.groundTruth,'Visible','on');
    set(data.humanTime,'Visible','on');
    set(data.machineTime,'Visible','on');
    set(data.counter,'Visible','on');
    set(data.currentRound,'Visible','on','string','-','Foregroundcolor',[1 0 0]);
    set(data.humanPoints,'Visible','on');
    set(data.machinePoints,'Visible','on');
    % Textfield
    set(data.roundsTextPanel,'Visible','on');
    set(data.humanTextPanel,'Visible','on');
    set(data.machineTextPanel,'Visible','on');
    set(data.classTextPanel,'Visible','on');
    set(data.timeTextPanel,'Visible','on');
    set(data.pointsTextPanel,'Visible','on');
    set(data.groundTruthTextPanel,'Visible','on');
    % Name Enter
    set(data.nameInputEditText,'Visible','off');
    set(data.nameInputEditText,'Enable','off');