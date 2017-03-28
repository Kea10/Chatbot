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
            obj.Map = zeros(memoryInstance);
        end
        function a = updateStimulus(obj, memoryInstance1, memoryInstance2)
            for idx = 1:numel(obj.Map)
                element1 = memoryInstance1.Mem(idx);
                element2 = memoryInstance2.Mem(idx);
                obj.Map(idx) = abs(element1 - element2);
            end
        end
    end
    
end

