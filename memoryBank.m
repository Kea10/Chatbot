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
        % weight is a precentage. In the function it is used relative to
        % the capacity.
        function a = addValue(obj, data, weight)
            for i = 1:numel(bank)
                element = array(i);
                element.weight = element.weight * ((weight / 100) * capacity);
            end
        end
            
    end
    
end

