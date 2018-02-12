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
heatmap = HeatMap(memory.Mem);
%for idx = 1:numel(memory.wordMem)
%                element = memory.wordMem(idx).Name;
%                heatmap.RowLabels(idx) = element;
%                heatmap.ColumnLabels(idx) = element;
%end
