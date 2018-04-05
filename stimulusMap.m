classdef stimulusMap
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Map
    end
    
    methods
        function obj = set.Map(obj, value)
            obj.Map = value;
        end
        function value = get.Map(obj)
            value = obj.Map;
        end
        function obj = stimulusMap(memoryInstance)
            obj.Map = zeros(size(memoryInstance.Mem));
        end
        function [newinstance,obj] = updateStimulus(obj, memoryInstance1, memoryInstance2)
            threshold = .01;
            learningrate = .1;
            [trows,tcols] = size(memoryInstance2.Mem);
            for row = 1:trows
                for col = 1:tcols
                    if col > row
                        element1 = memoryInstance1.Mem(row,col);
                        element2 = memoryInstance2.Mem(row,col);
                        obj.Map(row,col) = element1 - element2;
                        if (abs(element1 - element2) >= threshold)
                            i = row
                            for r = 1:i
                                celement = memoryInstance2.Mem(r,i);
                                if i>col
                                    relement = memoryInstance2.Mem(col,i);
                                end
                                if i<col
                                    relement = memoryInstance2.Mem(col,i);
                                end
                                if (celement ~= element2)
                                   change = (element2 - celement)*relement*learningrate*obj.Map(row,col);
                                   celement = celement + change;
                                end
                                memoryInstance2.Mem(r,i) = celement
                            end
                            for c = i+1:tcols
                                celement = memoryInstance2.Mem(i,c);
                                if i>col
                                    relement = memoryInstance2.Mem(col,i);
                                end
                                if i<col
                                    relement = memoryInstance2.Mem(col,i);
                                end
                                if (celement ~= element2)
                                    change = (element2 - celement)*relement*learningrate*obj.Map(row,col);
                                    celement = celement + change;
                                end
                                memoryInstance2.Mem(i,c) = celement;
                            end
                            i = col
                            for r = 1:i
                                celement = memoryInstance2.Mem(r,i);
                                if i>row
                                    relement = memoryInstance2.Mem(row,i);
                                end
                                if i<row
                                    relement = memoryInstance2.Mem(row,i);
                                end
                                if (celement ~= element2)
                                    change = (element2 - celement)*relement*learningrate*obj.Map(row,col);
                                   celement = celement + change;
                                end
                                memoryInstance2.Mem(r,i) = celement;
                            end
                            for c = i+1:tcols
                                celement = memoryInstance2.Mem(i,c);
                                if i>row
                                    relement = memoryInstance2.Mem(row,i);
                                end
                                if i<row
                                    relement = memoryInstance2.Mem(row,i);
                                end
                                if (celement ~= element2)
                                    change = (element2 - celement)*relement*learningrate*obj.Map(row,col);
                                   celement = celement + change;
                                end
                                memoryInstance2.Mem(i,c) = celement;
                            end
                        end 
                    end
                end
            end
            newinstance = memoryInstance2;
        end
    end
    
end

