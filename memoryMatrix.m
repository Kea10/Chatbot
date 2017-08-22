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
            obj = readData(obj);
        end
        
        % The next two functions take an index or a string respectivly and
        % turn them in to the other using the wordMem array. It is a
        % convient function for other methods.
        
        function word = indexToWord(obj, n)
            word = '';
            for idx = 1:numel(obj.wordMem)
                element = obj.wordMem(idx);
                if element.Index == n
                    word = element;
                end
            end
        end
        
        function index = wordToIndex(obj, n)
            index = 'does not exist');
            for idx = 1:size(obj.wordMem, 2)
                element = obj.wordMem(idx);
                if strcmp(element.Name, char(n))
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
            stringa = wordToIndex(obj, a);
            stringb = wordToIndex(obj, b);
            correlation = 1;
            correlation = obj.Mem(stringa,stringb);
        end
        
        % Sets the correlation between two strings in the memory matrix to a certain value.
        
        function obj = setCorrelation(obj, a, b, correlation)
            stringa = wordToIndex(obj, a);
            stringb = wordToIndex(obj, b);
            
            %Will probally add a bool to determine whether it will be added
            %to bottom-left or top-right memory
            obj.Mem(stringa,stringb) = correlation;
            
        end
        
        function obj = learnWord(obj, word)
            wordMem(wordMem.size + 2) = word;
        end
        
        function obj = parseText(obj, text)
           array = text;
           textdata = string({});
           parsedtext = strsplit(array);
           for idx = 1:numel(parsedtext)
                element = char(parsedtext(idx));
                thing = wordToIndex(obj, element);
                if strcmp(thing, 'does not exist')
                    word = Word(element,0,'unknown')
                    learnWord(obj, word);
                else
                word = indexToWord(obj, thing);
                end
                switch word.Type
                    case 'lverb'
                         
                    case 'noun'
                       textdata(size(textdata,2)+1) = word.Name;
                    case 'adjective'
                       textdata(size(textdata,2)+1) = word.Name;
                    case 'unknown'
                        
                        
                end
           end
           obj = changeData(obj, textdata);
        end
        function obj = changeData(obj, textdata)
             for idx = 1:numel(textdata)
                element = textdata(idx);
                for idx = idx:numel(textdata)
                    corelement = textdata(idx);
                    obj = setCorrelation(obj, element, corelement, (getCorrelation(obj, element, corelement) + 1) / 2);
                end
             end
        end
        function obj = writeData(obj)
            MemSaveData = obj.Mem;
            WordMemSaveData = obj.wordMem;
            save('MemoryData.mat', 'MemSaveData');
            save('WordMemoryData.mat', 'WordMemSaveData');
        end
        function obj = readData(obj)
            load('MemoryData.mat');
            load('WordMemoryData.mat');
            obj.Mem = MemSaveData;
            obj.wordMem = WordMemSaveData;
        end
    end
end
