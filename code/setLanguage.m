function setLanguage(w,english)
    data = w.UserData;
    if(english == 1)
        % save language
        data.englishLanguage = 1;
        % Status
        set(data.roundsTextPanel,'string','Round');
        set(data.humanTextPanel,'string','Human');
        set(data.machineTextPanel,'string','Machine');
        set(data.classTextPanel,'string','Class');
        set(data.timeTextPanel,'string','Time [ms]');
        set(data.pointsTextPanel,'string','Points');
        set(data.groundTruthTextPanel,'string','Ground Truth');        
        % Output
        data.drawTextOutput = 'Draw';
        data.winTextOutput = 'You win';
        data.loseTextOutput = 'You lose';
        data.catTextOutput = 'Cat';
        data.dogTextOutput = 'Dog';
        data.fishTextOutput = 'Fish';
        data.humanTextOutput = 'Human';
        data.BeforeStartTextOutput = 'Press Enter to start';
        data.NextRoundTextOutput = 'Press Enter for next round';
        set(w,'UserData',data);
        set(data.counter,'string',data.BeforeStartTextOutput);
    else
        % save language
        data.englishLanguage = 0;
        set(w,'UserData',data);
    end;
