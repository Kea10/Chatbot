classdef memoryMatrix
    %The memory of the chatbot put into the form of a matrix
    %Used to make associations
    
    properties
        Mem
        wordMem
    end
    
    methods
        function obj = set.Mem(obj, value)
            obj.Mem = value;
        end
        function obj = set.wordMem(obj, value)
            obj.wordMem = value; 
        end
        function value = get.Mem(obj)
            value = obj.Mem;
        end
        function value = get.wordMem(obj)
            value = obj.wordMem;
        end
        function obj = Init(obj)
            Ball = Word('ball', 1);
            Cool = Word('cool', 2);
            %Test words
            obj.wordMem = [Ball, Cool];
            sz = size(obj.wordMem);
            sz = sz(1,2);
            obj.Mem = zeros([sz, sz]);
        end
        function word = indexToWord(obj, n)
            for idx = 1:numel(obj.wordMem)
                element = obj.wordMem(idx);
                if element.Index == n
                    word = element.Name;
                end
            end
        end
        function index = wordToIndex(obj, n)
            for idx = 1:numel(obj.wordMem)
                element = obj.wordMem(idx);
                if element.Name == n
                    index = element.Index;
                end
            end
        end
        function correlation = getCorrelation(obj, a, b)
            a = wordToIndex(a);
            b = wordToIndex(b);
            correlation = 1;
            if b > a
                correlation = obj.Mem(a,b);
            end
            if a > b
                correlation = obj.Mem(b,a);
            end
            %Might be changed based on future uses of the memMatrix 
            %i.e the bottom-left might be different than the upper-right
            %portion
        end
    end
    
end

