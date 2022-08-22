function keyboardListener(fig_obj, eventDat, w)
    data = w.UserData;
    key = eventDat.Key;
    
    % Restart game
    if (strcmp (key , 'return') && data.isGameOver == true) || ( strcmp (key , 'm') && data.humanHasAnswered && data.machineHasAnswered )
        % Button image
        buttonsImg = imread('guiImages/buttons.png');
        imshow(buttonsImg,'Parent',data.panelButtonAxes);
        % Show game
        showGame(data);
        % Init values
        data.isGameOver = false;
        data.enterName = false;
        data.showHighScore = false;
        data.keysDCOpen = false;
        data.inWaitStatus = false;
        data.humanHasAnswered = false;
        data.machineHasAnswered = false;
        data.round = 0;
        data.humanPts = 0;
        data.machinePts = 0;
        data.currentGroundTruth = '';
        set(w,'UserData',data);
        % Hide Statistics
        setStatVisibility(data,'off');
        set(data.machineAnswer,'string','-','Foregroundcolor',[1 0 0]);
        set(data.machineTime,'string','-','Foregroundcolor',[1 0 0]);
        set(data.humanAnswer,'string','-','Foregroundcolor',[1 0 0]);
        set(data.humanTime,'string','-','Foregroundcolor',[1 0 0]);
        set(data.groundTruth,'string','-','Foregroundcolor',[1 0 0]);
        set(data.humanPoints,'string','-','Foregroundcolor',[1 0 0]);
        set(data.machinePoints,'string','-','Foregroundcolor',[1 0 0]);
        % Show Before Start Text
        set(data.counter,'string',data.BeforeStartTextOutput);
        return;
    end;
    
    % Enter Name
    if data.enterName == true
        return;
    end;
    
    % Show HighScore
    if strcmp (key , 'return') && data.showHighScore == true
        % Change Average Time to Time
        currStr = get(data.timeTextPanel,'string');
        set(data.timeTextPanel,'string',currStr(3:end));
        % change screen
        showHighScore(data,false);
        % Set enter Name
        data.enterName = true;
        set(w,'UserData',data);
        return;
    end;
    
    % Show results
    if strcmp (key , 'return') && data.round == 10 && data.humanHasAnswered && data.machineHasAnswered
        
        % Hide Class Line
        set(data.classTextPanel,'Visible','off');
        set(data.humanAnswer,'Visible','off');
        set(data.machineAnswer,'Visible','off');
        set(data.groundTruth,'Visible','off');
        set(data.groundTruthTextPanel,'Visible','off');
        
        % Change Time to Average Time
        currStr = get(data.timeTextPanel,'string');
        set(data.timeTextPanel,'string',['Ø ',currStr]);
        
        % Show average time
        averageTimeHuman = int64(sum(data.reactionTimesHuman) / 10);
        averageTimeMachine = int64(sum(data.reactionTimesMachine) / 10);
        set(data.humanTime,'string',num2str(averageTimeHuman));
        set(data.machineTime,'string',num2str(averageTimeMachine));
        
        % Button image
        buttonsImg = imread('guiImages/buttons.png');
        imshow(buttonsImg,'Parent',data.panelButtonAxes);
        
        % show end image
        if data.humanPts == data.machinePts
            % Draw
            set(data.counter,'string',data.drawTextOutput,'Foregroundcolor',[1 0 0]);
            endImg = imread('guiImages/draw.jpg');
        elseif data.humanPts > data.machinePts
            % Win
            set(data.counter,'string',data.winTextOutput,'Foregroundcolor',[1 0 0]);
            endImg = imread('guiImages/win.jpg');
        else
            % Loose
            set(data.counter,'string',data.loseTextOutput,'Foregroundcolor',[1 0 0]);
            endImg = imread('guiImages/loose.jpg');
        end;
        imshow(endImg,'Parent',data.panelAxes);
        % Set HighScore flag
        data.showHighScore = true;
        set(w,'UserData',data);
        return;
    end;
    
    % Prepare for next countdown
    if strcmp (key , 'return') && ~data.inWaitStatus && data.humanHasAnswered && data.machineHasAnswered
        data.keysDCOpen = false;
        data.inWaitStatus = false;
        data.humanHasAnswered = false;
        data.machineHasAnswered = false;
        set(w,'UserData',data);
        % Hide Statistics
        setStatVisibility(data,'off');
        set(data.machineAnswer,'string','-','Foregroundcolor',[1 0 0]);
        set(data.machineTime,'string','-','Foregroundcolor',[1 0 0]);
        set(data.humanAnswer,'string','-','Foregroundcolor',[1 0 0]);
        set(data.humanTime,'string','-','Foregroundcolor',[1 0 0]);
        set(data.groundTruth,'string','-','Foregroundcolor',[1 0 0]);
    end;

    % User choosed cat
    if data.keysDCOpen & key == '1'
        
        % Button image
        buttonsImg = imread('guiImages/buttons_cat.png');
        imshow(buttonsImg,'Parent',data.panelButtonAxes);
        
        % Time
        data.humanEndTime = datevec(now);
        timeDiff = data.humanEndTime - data.humanStartTime;
        HumanTime = int64( 1000 * (timeDiff(6) + 60 * (timeDiff(5) + timeDiff(4) * 60  ) ) );
        data.reactionTimesHuman = [data.reactionTimesHuman;HumanTime];
        set(data.humanAnswer,'string',data.catTextOutput,'Foregroundcolor',[1 0 0]);
        set(data.humanTime,'string',num2str(HumanTime),'Foregroundcolor',[1 0 0]);
        
        % Update points
        if data.currentGroundTruth(1) == 'K'
            data.humanPts = data.humanPts + 10 + getAddPoints(HumanTime);
        end;
        set(data.humanPoints,'string',num2str(data.humanPts),'Foregroundcolor',[1 0 0]);

        data.humanHasAnswered = true;
        data.keysDCOpen = false;
        
        % Show ground truth
        if data.machineHasAnswered && data.humanHasAnswered
            % show machine answer
            set(data.machineAnswer,'string',data.MachineAnswer,'Foregroundcolor',[1 0 0]);
            if data.currentGroundTruth(1) == 'K'
                data.currentGroundTruth = data.catTextOutput;
            elseif data.currentGroundTruth(1) == 'H'
                data.currentGroundTruth = data.dogTextOutput;
            elseif data.currentGroundTruth(1) == 'F'
                data.currentGroundTruth = data.fishTextOutput;
            elseif data.currentGroundTruth(1) == 'M'
                data.currentGroundTruth = data.humanTextOutput;
            end;
            % Show Next Round message
            set(data.counter,'string',data.NextRoundTextOutput);
            % Show Statistics
            setStatVisibility(data,'on');
            % Save variables
            set(w,'UserData',data);
            set(data.groundTruth,'string',data.currentGroundTruth,'Foregroundcolor',[1 0 0]);
        end;
        set(w,'UserData',data);

    % User choosed dog
    elseif data.keysDCOpen & key == '2'
        
        % Button image
        buttonsImg = imread('guiImages/buttons_dog.png');
        imshow(buttonsImg,'Parent',data.panelButtonAxes);
        
        % Time
        data.humanEndTime = datevec(now);
        timeDiff = data.humanEndTime - data.humanStartTime;
        HumanTime = int64( 1000 * (timeDiff(6) + 60 * (timeDiff(5) + timeDiff(4) * 60  ) ) );
        data.reactionTimesHuman = [data.reactionTimesHuman;HumanTime];
        set(data.humanAnswer,'string',data.dogTextOutput,'Foregroundcolor',[1 0 0]);
        set(data.humanTime,'string',num2str(HumanTime),'Foregroundcolor',[1 0 0]);
        
        % Update points
        if data.currentGroundTruth(1) == 'H'
            data.humanPts = data.humanPts + 10 + getAddPoints(HumanTime);
        end;
        set(data.humanPoints,'string',num2str(data.humanPts),'Foregroundcolor',[1 0 0]);

        data.humanHasAnswered = true;
        data.keysDCOpen = false;
        
        % Show ground truth
        if data.machineHasAnswered && data.humanHasAnswered
            % show machine answer
            set(data.machineAnswer,'string',data.MachineAnswer,'Foregroundcolor',[1 0 0]);
            if data.currentGroundTruth(1) == 'K'
                data.currentGroundTruth = data.catTextOutput;
            elseif data.currentGroundTruth(1) == 'H'
                data.currentGroundTruth = data.dogTextOutput;
            elseif data.currentGroundTruth(1) == 'F'
                data.currentGroundTruth = data.fishTextOutput;
            elseif data.currentGroundTruth(1) == 'M'
                data.currentGroundTruth = data.humanTextOutput;
            end;
            % Show Next Round message
            set(data.counter,'string',data.NextRoundTextOutput);
            % Show Statistics
            setStatVisibility(data,'on');
            % Save variables
            set(w,'UserData',data);
            set(data.groundTruth,'string',data.currentGroundTruth,'Foregroundcolor',[1 0 0]);
        end;
        set(w,'UserData',data);
        
    % User choosed fish
    elseif data.keysDCOpen & key == '3'
        
        % Button image
        buttonsImg = imread('guiImages/buttons_fish.png');
        imshow(buttonsImg,'Parent',data.panelButtonAxes);
        
        % Time
        data.humanEndTime = datevec(now);
        timeDiff = data.humanEndTime - data.humanStartTime;
        HumanTime = int64( 1000 * (timeDiff(6) + 60 * (timeDiff(5) + timeDiff(4) * 60  ) ) );
        data.reactionTimesHuman = [data.reactionTimesHuman;HumanTime];
        set(data.humanAnswer,'string',data.fishTextOutput,'Foregroundcolor',[1 0 0]);
        set(data.humanTime,'string',num2str(HumanTime),'Foregroundcolor',[1 0 0]);
        
        % Update points
        if data.currentGroundTruth(1) == 'F'
            data.humanPts = data.humanPts + 10 + getAddPoints(HumanTime);
        end;
        set(data.humanPoints,'string',num2str(data.humanPts),'Foregroundcolor',[1 0 0]);

        data.humanHasAnswered = true;
        data.keysDCOpen = false;
        
        % Show ground truth
        if data.machineHasAnswered && data.humanHasAnswered
            % show machine answer
            set(data.machineAnswer,'string',data.MachineAnswer,'Foregroundcolor',[1 0 0]);
            if data.currentGroundTruth(1) == 'K'
                data.currentGroundTruth = data.catTextOutput;
            elseif data.currentGroundTruth(1) == 'H'
                data.currentGroundTruth = data.dogTextOutput;
            elseif data.currentGroundTruth(1) == 'F'
                data.currentGroundTruth = data.fishTextOutput;
            elseif data.currentGroundTruth(1) == 'M'
                data.currentGroundTruth = data.humanTextOutput;
            end;
            % Show Next Round message
            set(data.counter,'string',data.NextRoundTextOutput);
            % Show Statistics
            setStatVisibility(data,'on');
            % Save variables
            set(w,'UserData',data);
            set(data.groundTruth,'string',data.currentGroundTruth,'Foregroundcolor',[1 0 0]);
        end;
        set(w,'UserData',data);
        
    % User choosed human
    elseif data.keysDCOpen & key == '4'
        
        % Button image
        buttonsImg = imread('guiImages/buttons_human.png');
        imshow(buttonsImg,'Parent',data.panelButtonAxes);
        
        % Time
        data.humanEndTime = datevec(now);
        timeDiff = data.humanEndTime - data.humanStartTime;
        HumanTime = int64( 1000 * (timeDiff(6) + 60 * (timeDiff(5) + timeDiff(4) * 60  ) ) );
        data.reactionTimesHuman = [data.reactionTimesHuman;HumanTime];
        set(data.humanAnswer,'string',data.humanTextOutput,'Foregroundcolor',[1 0 0]);
        set(data.humanTime,'string',num2str(HumanTime),'Foregroundcolor',[1 0 0]);
        
        % Update points
        if data.currentGroundTruth(1) == 'M'
            data.humanPts = data.humanPts + 10 + getAddPoints(HumanTime);
        end;
        set(data.humanPoints,'string',num2str(data.humanPts),'Foregroundcolor',[1 0 0]);

        data.humanHasAnswered = true;
        data.keysDCOpen = false;
        
        % Show ground truth
        if data.machineHasAnswered && data.humanHasAnswered
            % show machine answer
            set(data.machineAnswer,'string',data.MachineAnswer,'Foregroundcolor',[1 0 0]);
            if data.currentGroundTruth(1) == 'K'
                data.currentGroundTruth = data.catTextOutput;
            elseif data.currentGroundTruth(1) == 'H'
                data.currentGroundTruth = data.dogTextOutput;
            elseif data.currentGroundTruth(1) == 'F'
                data.currentGroundTruth = data.fishTextOutput;
            elseif data.currentGroundTruth(1) == 'M'
                data.currentGroundTruth = data.humanTextOutput;
            end;
            % Show Next Round message
            set(data.counter,'string',data.NextRoundTextOutput);
            % Show Statistics
            setStatVisibility(data,'on');
            % Save variables
            set(w,'UserData',data);
            set(data.groundTruth,'string',data.currentGroundTruth,'Foregroundcolor',[1 0 0]);
        end;
        set(w,'UserData',data);

    % Next round
    elseif ~data.keysDCOpen & ~data.inWaitStatus & strcmp (key , 'return')
        
        data.inWaitStatus = true;
        set(w,'UserData',data);

        % show black image
        background = imread('guiImages/black.png');
        imshow(background,'Parent',data.panelAxes);
        
        % Button image
        buttonsImg = imread('guiImages/buttons.png');
        imshow(buttonsImg,'Parent',data.panelButtonAxes);
        
        % Show new points
        set(data.humanPoints,'string',num2str(data.humanPts),'Foregroundcolor',[1 0 0]);
        set(data.machinePoints,'string',num2str(data.machinePts),'Foregroundcolor',[1 0 0]);

        % Update round
        data.round = data.round + 1;
        set(data.currentRound,'string',strcat(num2str(data.round),'/10'),'Foregroundcolor',[1 0 0]);

        % get next image number
        currPerm = randperm(data.randStream,1000);
        %currPerm = randperm(data.randStream,2500);
        currNr = currPerm(1) + 9999;

        % get next inage class
        prefixArr = [{'data/CatTest/cat.'};{'data/DogTest/dog.'};{'data/HumanTest/human.'};{'data/FishTest/fish.'}];
        GroundTruthArr = [{'Katze'},{'Hund'},{'Mensch'},{'Fisch'}];
        currPerm = randperm(data.randStream,4);
        currClass = currPerm(1);

        % get current ground truth
        data.currentGroundTruth = GroundTruthArr{currClass};

        % Load image
        nextImage = strcat(prefixArr{currClass},num2str(currNr),'.jpg');
        img = readAndPreprocessImage(nextImage);

        % Countdown
        set(data.counter,'string','3','Foregroundcolor',[1 0 0]);
        pause(1);
        set(data.counter,'string','2','Foregroundcolor',[1 0 0]);
        pause(1);
        set(data.counter,'string','1','Foregroundcolor',[1 0 0]);
        pause(1);
        set(data.counter,'string','','Foregroundcolor',[1 0 0]);
        
        % show image
        imshow(img,'Parent',data.panelAxes);

        % Save start time
        data.humanStartTime = datevec(now);
        
        % Update Game Status
        data.inWaitStatus = false;
        data.keysDCOpen = true;
        
        % Save Variables
        set(w,'UserData',data);

        % --- Machine Classification ---
        tic
        imageFeatures = activations(data.classifier.convnet, img, data.classifier.featureLayer);
        MachineLabel = predict(data.classifier.classifier, imageFeatures);
        MachineTime = int64((toc) * 1000);
        data.reactionTimesMachine = [data.reactionTimesMachine;MachineTime];
        
        % Show machine answer and update points
        if MachineLabel == data.classifier.classifier.ClassNames(1)
            data.MachineAnswer = data.catTextOutput;
            if data.currentGroundTruth(1) == 'K'
                data.machinePts = data.machinePts + 10;
            end;
        elseif MachineLabel == data.classifier.classifier.ClassNames(2)
            data.MachineAnswer = data.dogTextOutput;
            if data.currentGroundTruth(1) == 'H'
                data.machinePts = data.machinePts + 10;
            end;
        elseif MachineLabel == data.classifier.classifier.ClassNames(3)
            data.MachineAnswer = data.fishTextOutput;
            if data.currentGroundTruth(1) == 'F'
                data.machinePts = data.machinePts + 10;
            end;
        elseif MachineLabel == data.classifier.classifier.ClassNames(4)
            data.MachineAnswer = data.humanTextOutput;
            if data.currentGroundTruth(1) == 'M'
                data.machinePts = data.machinePts + 10;
            end;
        else
            disp('ERROR: Unknown Machine Answer!');
        end;
        
        % update points, time in user interface
        set(data.machinePoints,'string',num2str(data.machinePts),'Foregroundcolor',[1 0 0]);
        set(data.machineTime,'string',MachineTime,'Foregroundcolor',[1 0 0]);
        data.machineHasAnswered = true;
        
        % Show ground truth
        if data.machineHasAnswered && data.humanHasAnswered
            % show machine answer
            set(data.machineAnswer,'string',data.MachineAnswer,'Foregroundcolor',[1 0 0]);
            if data.currentGroundTruth(1) == 'K'
                data.currentGroundTruth = data.catTextOutput;
            elseif data.currentGroundTruth(1) == 'H'
                data.currentGroundTruth = data.dogTextOutput;
            elseif data.currentGroundTruth(1) == 'F'
                data.currentGroundTruth = data.fishTextOutput;
            elseif data.currentGroundTruth(1) == 'M'
                data.currentGroundTruth = data.humanTextOutput;
            end;
            % Show Next Round message
            set(data.counter,'string',data.NextRoundTextOutput);
            % Show Statistics
            setStatVisibility(data,'on');
            % Save variables
            set(w,'UserData',data);
            set(data.groundTruth,'string',data.currentGroundTruth,'Foregroundcolor',[1 0 0]);
        end;
        set(w,'UserData',data);
        
        % Hide image after X milliseconds
        timeDiff = datevec(now) - data.humanStartTime;
        elapsedMilliSecondsFromStart = int64( 1000 * (timeDiff(6) + 60 * (timeDiff(5) + timeDiff(4) * 60  ) ) );
        pause((getDisplayTime(data.round)-elapsedMilliSecondsFromStart)/1000);
        if ~(data.showHighScore)
            imshow(background,'Parent',data.panelAxes);
        end;
    end;