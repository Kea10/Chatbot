% Init
close all;
global debugvar;
global MemSaveData;
global WordMemSaveData;
memory = memoryMatrix;
memory = memory.Init();
memory = memory.parseText('Apple are not cute');
memory = memory.writeData();
memory = memory.readData();
disp(memory.Mem);
