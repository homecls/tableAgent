classdef tableAgent < handle
    % ---------------------------------------------------------------
    properties (Access = public)
        % properties of data
        table
        tablename
        tableProperties
        rowselected
        
        % properties of id
        idnames
        id
        id1
        id2
        id3
        
        %properties of time
        
        time
        datenumOrg
        datenum
        datenumEom
        datestr
        datetime
        frequency
        istimeContinuous

        % properties of panel
        isbalanced
    end

    % ---------------------------------------------------------------
    methods
        function [obj] = tableAgent(Tab,varargin)
            obj.table = Tab;
            obj.tablename = inputname(1);
            obj.tableProperties = Tab.Properties;
            obj.rowselected = true(height(Tab),1);
            narginchk(1,2);
            % obj.frequency = 'monthly';
            switch nargin
                case {1}
                    
                case {2} 
                    % #2argin == [id time]
                    % get the idnames
                    it = (varargin{1});
                    obj.idnames = it(1:end-1);
                    nid = numel(obj.idnames);
                    for ii=1:nid
                        obj.(char("id"+ii)) = Tab.(char(it(ii)));
                    end
                    
                    % get the time and convert it to datenumeom
                    time = Tab.(char(it(end)));
                    switch lower(obj.frequency)
                        case {'month','monthly'}
                            tdatenum = makeitDatenum(time);
                            tdatenumEom = makeitEom(tdatenum);
                            obj.datenumOrg = tdatenum;
                            obj.datenum = tdatenumEom;
                            obj.datenumEom = tdatenumEom;
                            obj.datestr = datestr(tdatenumEom);
                            obj.datetime = datetime(tdatenumEom,'ConvertFrom','datenum');
                            % export the time variables to table
                            obj.table.Datenum = obj.datenum;
                            obj.table = retimeTableMonthlyEomWithAllMonthInYear(obj.table,'Datenum');
%                             obj.table.Datetime = obj.datetime;
%                             obj.table.Datestr = obj.datestr;
                        case {'year','yearly'}
                            tdatenum = makeitDatenum(time);
                            tdatenumEom = makeitEom(tdatenum);
                            obj.datenumOrg = tdatenum;
                            obj.datenum = tdatenumEom;
                            obj.table.Datenum = obj.datenum;
                            obj.table.Datetime = obj.datetime;
                            obj.table.Datestr = obj.datestr;
                        case {'quarter','quarterly'}
                        otherwise
                            
                    end
                case {3} 
                    % #3 argin == frequency
                otherwise
                    error("# of arg is is wrong")
            end
        end
    % 
    % methods of . and () acess
        obj = row(obj,idstr)
        obj = gen(obj,strcmd,fn1,fn2)
        a = subsref(obj,S)
        B = subsasgn(obj, S, V)
        tf = areParensNext(S)
    end % method
end % classdef