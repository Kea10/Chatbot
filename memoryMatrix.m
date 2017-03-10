classdef memoryMatrix
    %The memory of the chatbot put into the form of a matrix
    %Used to make associations
    
    properties
        Mem
        wordMem
    end
    
    methods
        function Init(obj)
            
        end
        function word = indexToWord(obj, n)
            
        end
        function index = wordToIndex(obj, n)
            
        end
        function correlation = getCorrelation(obj, a, b)
            a = wordToIndex(a);
            b = wordToIndex(b);
            correlation = Mem(a,b);
            %Might be changed based on future uses of the memMatrix 
            %i.e the bottom-left might be different than the upper-right
            %portion
        end
    end
    
end

