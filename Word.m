classdef Word
    
    % An index to help the memoryMatrix class. Correlates a string to a
    % number so that the memory matrix can correctly identify what it's
    % values signify.
    
    properties
        
        Name
        
        Index
        
        Type
        
    end
    
    methods
        
        % A simple contstructor for the word class
        function value = get.Name(obj)
            value = obj.Name;
        end
        function obj = set.Name(obj, value)
            obj.Name = value;
        end
        function value = get.Type(obj)
            value = obj.Type;
        end
        function obj = set.Type(obj, value)
            obj.Type = value;
        end
        function value = get.Index(obj)
            value = obj.Index;
        end
        function obj = set.Index(obj, value)
            obj.Index = value;
        end

        function obj = Word(name, index, data)
            obj.Name = name;
            obj.Index = index;
            obj.Type = data;
        end
        
    end
    
end

