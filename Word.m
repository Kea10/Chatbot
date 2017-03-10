classdef Word
    %An index to help the memoryMatrix class
    
    properties
        Name
        Index
    end
    
    methods
        function obj = Word(name, index)
            obj.Name = name;
            obj.Index = index;
        end
    end
    
end

