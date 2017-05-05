classdef memoryMatrix
    %The memory of the chatbot put into the form of a matrix
    %Used to make associations between words so that the chatbot can create
    %sentences and come to conclusions.
    
    properties
        
        % Mem is a matrix used to represent the main memory of the chatbot. 
        % The memory remembers correlations between words so that the
        % chatbot can use them to create sentences and come to conclusions.
        
        Mem
        
        % wordMem is an array of words used as an index for the mem matrix
        % in order to correlate a position on the matrix with two words.
        
        wordMem
    end
   
    methods
        
        % A list of get/set methods for Mem and wordMem
        
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
        
        % An Init method for the matrix. Right now it is just sets up a
        % bunch of predefined words, but it will eventually read/write to a
        % text document. 
        
        function obj = Init(obj)
            Ball = Word('ball', 1, 'noun');
            Cool = Word('cool', 2, 'adjective');
            Are = Word('are', 3, 'lverb');
            %Test words
            obj.wordMem = [Ball, Cool, Are];
            sz = size(obj.wordMem);
            sz = sz(1,2);
            obj.Mem = zeros([sz, sz]);
        end
        
        % The next two functions take an index or a string respectivly and
        % turn them in to the other using the wordMem array. It is a
        % convient function for other methods.
        
        function word = indexToWord(obj, n)
            for idx = 1:numel(obj.wordMem)
                element = obj.wordMem(idx);
                if element.Index == n
                    word = element;
                end
            end
        end
        
        function index = wordToIndex(obj, n)
            index = 'does not exist';
            for idx = 1:numel(obj.wordMem)
                element = obj.wordMem(idx);
                if strcmp(element.Name, lower(n))
                    index = element.Index;
                end
            end
        end
        
        function index = stringToIndex(obj, n, type)
            for idx = 1:numel(obj.wordMem)
                element = obj.wordMem(idx);
                if element.Name == n && element.Type == type
                    index = element.Index;
                end
            end
        end
        
        % A handy function to get a correlation between two strings in the
        % memory matrix.
        
        function correlation = getCorrelation(obj, a, b)
            a = wordToIndex(a);
            b = wordToIndex(b);
            correlation = 1;
            correlation = obj.Mem(a,b);
        end
        
        % Sets the correlation between two strings in the memory matrix to a certain value.
        
        function obj = setCorrelation(obj, a, b, correlation)
            a = wordToIndex(a);
            b = wordToIndex(b);
            
            %Will probally add a bool to determine whether it will be added
            %to bottom-left or top-right memory
            
            if b > a
                obj.Mem(a,b) = correlation;
            end
            
            if a > b
                obj.Mem(b,a) = correlation;
            end
        end
        
        function obj = parseText(obj, text)
           array = text;
           textdata = {};
           parsedtext = strsplit(array);
           for idx = 1:numel(parsedtext)
                element = char(parsedtext(idx));
                
                thing = wordToIndex(obj, element);
                index = indexToWord(obj, thing);
                switch index.Type
                    case 'lverb'
                         textdata(numel(textdata,2)+1) = {'set'};
                         textdata(numel(textdata,2)+1) = {wordToIndex(obj, char(parsedtext(idx - 1))) + ' = ' + wordToIndex(obj, char(parsedtext(idx + 1)))};
                         textdata(numel(textdata,2)+1) = {'end'};
                    case 'noun'
                       
                    case 'adjective'
                        
                end
               
           end
             ChangeData(obj, textdata);
        end
        function obj = ChangeData(obj, textdata)
             command = '';
             for idx = 1:numel(textdata)
                element = textdata(idx);
                if strcmp(textdata, 'set')
                    command = 'set';
                end
                if strcmp(command, 'set')
                    text = strsplit(wordToIndex(name), ' = ');
                    word = wordToIndex(text(0));
                    property = wordToIndex(text(1));
                    setCorrelation(word, property,((getCorrelation(word, property) + 1) / 2));
                end
             end
        end
    end
    
end

