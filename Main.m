% Init
close all;
global debugvar;
global MemSaveData;
global WordMemSaveData;
memory = memoryMatrix;
memory = memory.Init();
memory.Mem = zeros(size(memory.Mem));
smap = stimulusMap(memory);
previousinstance = memory;
memory = memory.parseText('cats are cute');
previousinstance = currentinstance;
currentinstance = memory;
for i = 1:5
    [newinstance,smap] = smap.updateStimulus(previousinstance,currentinstance);
    previousinstance = currentinstance;
    currentinstance = newinstance;
end
memory = memory.writeData();
memory = memory.readData();
heatmap = HeatMap(memory.Mem);
