% Init
close all;
global debugvar;
global MemSaveData;
global WordMemSaveData;
memory = memoryMatrix;
memory = memory.Init();
memory = memory.parseText('cats are cool');
memory = memory.writeData();
memory = memory.readData();
global a;
a={memory.Mem};
b={memory.wordMem};
row_no=1; %%where wants to insert
a(1:row_no-1,:) = a(1:row_no-1,:);
tp =a(row_no:end,:);
a(row_no,:)=b;
a(row_no+1:end+1,:) =tp;
openvar('a');
disp(memory.know);
