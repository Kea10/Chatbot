classdef memoryBank
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        bank
        capacity
    end
    
    methods
        function obj = set.bank(obj, value)
            obj.bank = value;
        end
        function value = get.bank(obj)
            value = obj.bank;
        end
        function obj = set.capacity(obj, value)
            obj.capacity = value;
        end
        function value = get.capacity(obj)
            value = obj.capacity;
        end
        function a = addValue(obj, data, weight)
            for i = 1:numel(bank)
                element = array(i);
                
            end
        end
            
    end
    
end

