% Init
close all;
global debugvar;
global MemSaveData;
global WordMemSaveData;
memory = memoryMatrix;
memory = memory.Init();
memory = memory.parseText('Cat are cool');
memory = memory.writeData();
disp(memory.Mem);
