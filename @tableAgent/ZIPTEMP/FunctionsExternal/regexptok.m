function [tok, strtail, strhead] = regexptok(strorg, strsub, varargin)
if isstring(strorg)
    
   strorg = char(strorg); 
end
if nargin == 3
    no = varargin{1}; 
else
    no = 1;
end
ptendstr = length(strorg);
a = regexp(strorg,strsub,'start');
b = regexp(strorg,strsub,'end');
if ~isempty(a)
    if a(no)==1
        tok = strorg(a(no):b(no));
        strtail = strorg(b(no)+1:ptendstr);
        strhead = '';
    elseif a(no)>1;
        tok = strorg(a(no):b(no));
        strtail = strorg(b(no)+1:ptendstr);
        strhead = strorg(1:a(no)-1);
        
    end
    
else
            tok = '';
        strtail = '';
        strhead = '';
end
end