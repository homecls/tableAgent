function num = date2num(datem)
% from date type in matlab ->  20100112 num
    datev = datevec(datem);
    num = datev(:,1) *10000 + datev(:,2)*100 + datev(:,3);
end