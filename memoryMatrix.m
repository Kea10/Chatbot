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
        
        know
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
            index = 'does not exist';
            for idx = 1:size(obj.wordMem, 2)
                element = obj.wordMem(idx);
                if strcmp(element.Name, char(n))
                    index = element.Index;
                end
            end
        end
        
        function thing = stringToWord(obj, n)
            index = 'unknown';
            for idx = 1:numel(obj.wordMem)
                element = obj.wordMem(idx);
                if strcmp(element.Name, n)
                    index = element.Index;
                end
            end
            thing = indexToWord(obj,index);
            if strcmp(index, 'unknown')
                thing = Word(n, 'does not exist', 'unknown');
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
        
        function obj = learnWord(obj, thing)
            [x,y] = size(obj.wordMem)
            obj.wordMem(y + 1) = thing;
            [x,y] = size(obj.Mem);
            obj.Mem(x+1,y+1) = 0;
        end
        
        function obj = parseText(obj, text)
           array = text;
           textdata = string({});
           parsedtext = strsplit(array);
           for idx = 1:numel(parsedtext)
                element = char(parsedtext(idx));
                thing = wordToIndex(obj, element);
                if strcmp(thing, 'does not exist')
                    [x,y] = size(obj.wordMem);
                    word = Word(element, y + 1, 'unknown');
                    if strcmp(word.Name, 'not')
                    word.Type = 'negative';
                    end
                    obj = learnWord(obj, word);
                else
                word = indexToWord(obj, thing);
                end
                if strcmp(word.Name, 'not')
                    word.Type = 'negative';
                end
                if strcmp(word.Name, 'a')
                    word.Type = 'article'
                end
                inSubject = false;
                switch word.Type
                    case 'lverb'
                       textdata(size(textdata,2)+1) = word.Name;
                    case 'noun'
                       textdata(size(textdata,2)+1) = word.Name;
                    case 'adjective'
                       textdata(size(textdata,2)+1) = word.Name;
                    case 'unknown'
                        textdata(size(textdata,2)+1) = word.Name;
                    case 'negative'
                        textdata(size(textdata,2)+1) = 'not';
                    case 'article'
                        
                end
           end
           obj = changeData(obj, textdata);
        end
        
        % textdata is a list of strings sent by the parseText function,
        % which make's textdata easier to read by changeData
        
        function obj = changeData(obj, textdata)
             idx = 1;
             alttextdata = textdata;
             
             %Begins by searching for linking verbs, such as 'are' or 'is'
             %and surrounds each side of the linking  verb in it's own set
             %of parenthesis, or group.
             
             while idx <= numel(textdata)
                element = textdata(idx);
                element = stringToWord(obj, element);
                if strcmp(element.Type, 'lverb')
                    obj = CorWG(obj, element.Name, textdata(1:idx-1));
                    obj = CorWG(obj, element.Name, textdata(idx+1:end));
                    alttextdata = ['(' alttextdata];
                    alttextdata = [alttextdata(1:(idx)) ')' alttextdata(idx+2:end)];
                    alttextdata = [alttextdata(1:idx+1) '(' alttextdata((idx+2):end)];
                    alttextdata = [alttextdata ')'];
                    disp(alttextdata);
                end
                idx = idx + 1;
             end
             textdata = alttextdata;
             idx = 1;
             
             %Interprets groups (needs to be fixed later so that there can
             %be groups within groups, but this is OK for now. Adds each
             %group or lone word into a component list.

             components = {};
             while idx <= numel(textdata)
                element = textdata(idx);
                if strcmp(element, '(')
                    sidx = idx + 1;
                    group = {};
                    while sidx <= numel(textdata)
                        selement = textdata(sidx);
                        if strcmp(selement, ')')
                            sidx = numel(textdata);
                            idx = sidx + 1;
                        else
                            group(numel(group)+1) = {selement};
                        end
                        sidx = sidx + 1;
                    end
                    components(numel(components)+1) = {group};
                end
                idx = idx + 1;
             end
             
             %Correlated each component to each component after it.
             
             idx = 1;
             while idx <= numel(components)
                 element = components(idx);
                 sidx = idx + 1;
                 while sidx <= numel(components)
                     selement = components(sidx);
                     obj = Cor(obj, element, selement);
                     sidx = sidx + 1;
                 end
                 idx = idx + 1 
             end
             
        end
        
        function obj = CorWW(obj, word1, word2)
            obj = setCorrelation(obj, word1, word2, (getCorrelation(obj, word1, word2)+1)/2);
            obj.know = obj.know + 2;
            setCorrelation(obj, word1, word1, (getCorrelation(obj, word1, word1)+1));
            setCorrelation(obj, word2, word2, (getCorrelation(obj, word2, word2)+1));
        end
        
        function obj = CorWG(obj, word, group)
            for idx = 1:numel(group)
                element = group(idx);
                obj = CorWW(obj, word, element);
            end
        end
        
        function obj = CorGW(obj, group, word)
            for idx = 1:numel(group)
                element = group(idx);
                obj = CorWW(obj, element, word);
            end
        end
        
        function obj = CorGG(obj, group1, group2)
            for idx = 1:numel(group1)
                element = group(idx);
                obj = CorWG(obj, element, group2);
            end
        end
        
        function obj = Cor(obj, item1, item2)
            if isstring(item1) && isstring (item2)
                obj = CorWW(obj, item1, item2);
            elseif isstring(item1) && isstring (item2) == false
                obj = CorWG(obj, item1, item2);
            elseif isstring(item1) == false && isstring (item2)
                obj = CorGW(obj, item1, item2);
            else
                obj = CorGG(obj, item1, item2);
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
            obj.Mem = MemSaveData;
            load('WordMemoryData.mat');
            obj.wordMem = WordMemSaveData;
        end
        
    end
end
