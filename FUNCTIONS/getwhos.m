function [varnames, varInfo]= getwhos()
varInfo = evalin('caller','whos');
varnames = string({varInfo.name}');

end


