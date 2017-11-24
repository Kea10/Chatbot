% Init
close all;
global debugvar;
global MemSaveData;
global WordMemSaveData;
memory = memoryMatrix;
memory = memory.Init();
memory = memory.parseText('cats are the cure to cancer');
memory = memory.writeData();
memory = memory.readData();
disp(memory.Mem);
