function setStatVisibility(data,visibility)
    set(data.humanTextPanel,'Visible',visibility);
    set(data.machineTextPanel,'Visible',visibility);
    set(data.groundTruthTextPanel,'Visible',visibility);
    set(data.classTextPanel,'Visible',visibility);
    set(data.humanAnswer,'Visible',visibility);
    set(data.machineAnswer,'Visible',visibility);
    set(data.groundTruth,'Visible',visibility);
    set(data.timeTextPanel,'Visible',visibility);
    set(data.humanTime,'Visible',visibility);
    set(data.machineTime,'Visible',visibility);
    set(data.pointsTextPanel,'Visible',visibility);
    set(data.humanPoints,'Visible',visibility);
    set(data.machinePoints,'Visible',visibility);