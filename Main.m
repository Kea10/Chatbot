% Init
close all;
global debugvar;
memory = memoryMatrix;
memory = memory.Init();
memory = memory.writeData();
memory = memory.parseText('Ball are cool');
disp(memory.Mem);
