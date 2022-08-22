function showHighScore(data,update)
    % --- Hide elements ---
    if(~update)
        % Status
        set(data.humanAnswer,'Visible','off');
        set(data.machineAnswer,'Visible','off');
        set(data.groundTruth,'Visible','off');
        set(data.humanTime,'Visible','off');
        set(data.machineTime,'Visible','off');
        set(data.currentRound,'Visible','off');
        set(data.humanPoints,'Visible','off');
        set(data.machinePoints,'Visible','off');
        % Textfield
        set(data.roundsTextPanel,'Visible','off');
        set(data.humanTextPanel,'Visible','off');
        set(data.machineTextPanel,'Visible','off');
        set(data.classTextPanel,'Visible','off');
        set(data.timeTextPanel,'Visible','off');
        set(data.pointsTextPanel,'Visible','off');
        set(data.groundTruthTextPanel,'Visible','off');
        % Name Enter
        set(data.nameInputEditText,'Visible','on');
        set(data.nameInputEditText,'Enable','on');
        % Counter text
        if data.englishLanguage == 1
            set(data.counter,'String','Enter your name ...');
        else
            set(data.counter,'String','Gib deinen Namen ein ...');
        end;
    else
        % Counter text
        if data.englishLanguage == 1
            set(data.counter,'String','');
        else
            set(data.counter,'String','');
        end;
    end;
    % --- Show High Score Table ---
    set(data.highScoreNameText0,'Visible','on','string','Name','Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText1,'Visible','on','string',data.highScoreTable(1,2),'Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText2,'Visible','on','string',data.highScoreTable(2,2),'Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText3,'Visible','on','string',data.highScoreTable(3,2),'Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText4,'Visible','on','string',data.highScoreTable(4,2),'Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText5,'Visible','on','string',data.highScoreTable(5,2),'Foregroundcolor',[0 0 0]);
    set(data.highScoreNameText6,'Visible','on','string',data.highScoreTable(6,2),'Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText0,'Visible','on','string','High Score','Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText1,'Visible','on','string',num2str(data.highScoreTable{1,1}),'Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText2,'Visible','on','string',num2str(data.highScoreTable{2,1}),'Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText3,'Visible','on','string',num2str(data.highScoreTable{3,1}),'Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText4,'Visible','on','string',num2str(data.highScoreTable{4,1}),'Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText5,'Visible','on','string',num2str(data.highScoreTable{5,1}),'Foregroundcolor',[0 0 0]);
    set(data.highScorePointsText6,'Visible','on','string',num2str(data.highScoreTable{6,1}),'Foregroundcolor',[0 0 0]);