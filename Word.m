classdef Word
    
    % An index to help the memoryMatrix class. Correlates a string to a
    % number so that the memory matrix can correctly identify what it's
    % values signify.
    
    properties
        
        Name
        
        Index
        
    end
    
    methods
        
        % A simple contstructor for the word class

        function obj = Word(name, index)
            obj.Name = name;
            obj.Index = index;
        end
        
    end
    
end

