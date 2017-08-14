% Init
close all;
global debugvar;
global MemSaveData;
global WordMemSaveData;
memory = memoryMatrix;
memory = memory.Init();
memory = memory.writeData();
memory = memory.parseText('Ball are cool');
disp(memory.Mem);
