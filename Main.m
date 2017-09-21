% Init
close all;
global debugvar;
global MemSaveData;
global WordMemSaveData;
memory = memoryMatrix;
memory = memory.Init();
memory = memory.parseText('A chair is a piece of furniture');
memory = memory.writeData();2
memory = memory.readData();
disp(memory.Mem);
