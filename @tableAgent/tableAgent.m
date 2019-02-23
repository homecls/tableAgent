classdef tableAgent %< matlab.mixin.Copyable
    % ---------------------------------------------------------------
    properties (Access = public)
        % properties of data
        table
        tablename
        tableProperties
        
        
        rowselected
        colselected
        variablestored
        ISGROUPED
        groupid
        groupno
        groupvar
        
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
            narginchk(0,2);
            if nargin==0
                obj.table = table;
                obj.tablename = '';
                obj.rowselected = [];
                obj.colselected = [];
            else
                obj.table = Tab;
                obj.tablename = inputname(1);
                obj.tableProperties = Tab.Properties;
                obj.rowselected = true(height(Tab),1);
                
            end
        end
        % get functions
        function val = get.rowselected(obj)
            if isempty(obj.rowselected)
               val = 1:height(obj.table);
            else
                val = obj.rowselected;
            end
        end
        
        function val = get.colselected(obj)
            if isempty(obj.colselected)
               val = 1:width(obj.table);
            else
                val = obj.colselected;
            end
        end
        
        function val = get.ISGROUPED(obj)
            if isempty(obj.ISGROUPED)
                val = false;
            else
                val = obj.ISGROUPED;
            end
        end
        
        % disp function
        function [obj] = disp(obj)
            fprintf('A %s class based on table\n',class(obj));
            fprintf('\tobj.ISGROUPED \t\t= %g\n',obj.ISGROUPED)
            nrowSelected = numel(obj.rowselected);
            ncolSelected = numel(obj.colselected);
            [nrow,ncol] = size(obj.table);
            fprintf('\tobj.rowselected \t= %g/%g\n',nrowSelected,nrow)
            fprintf('\tobj.colselected \t= %g/%g\n\n  ',ncolSelected,ncol)
            display(obj.table);
        end
        
        function [obj] = dispclass(obj)
            fprintf('A %s class based on table\n',class(obj));
            fprintf('\tobj.ISGROUPED \t\t= %g\n',obj.ISGROUPED)
            nrowSelected = numel(obj.rowselected);
            ncolSelected = numel(obj.colselected);
            [nrow,ncol] = size(obj.table);
            fprintf('\tobj.rowselected \t= %g/%g\n',nrowSelected,nrow)
            fprintf('\tobj.colselected \t= %g/%g\n\n  ',ncolSelected,ncol)
            display(obj.table);
        end
        
        
        % methods of . and () acess
        obj = row(obj,idstr)
        obj = col(obj,strcol)
        obj = droprow(obj,strcol)
        obj = dropcol(obj,strrow)
        obj = keeprow(obj,strcol)
        obj = keepcol(obj,strrow)
        obj = gen(obj,strcmd,fn1,fn2)

        
        tf = areParensNext(S)
        sz = numArgumentsFromSubscript(t,s,context)
        Tsummary = summary(obj, colstr, rowstr, colsofsummary)
        rowdoble = rowstr2rowdouble(obj, idstr)
        [coldouble, colcellstr]= colstr2coldouble(obj, strcol)
        
        varargout = subsref(obj,S)
        obj = subsasgn(obj, S, V)
        [b,varargout] = subsrefDot(t,s)

        % function define for group
        obj = groupby(obj,colstr,coly,fn,colx)
        obj = genbygroup(obj,cmdstr,FNHANDLE_TEMP_,fname,varargin)
        
        % function copy key properties
        function obj = copykeyproperties(obj,obj1)
            % obj = tableAgent;
            % obj.table = obj1.table;
            obj.colselected = obj1.colselected;
            obj.rowselected = obj1.rowselected;
            obj.groupid = obj1.groupid;
            obj.groupno = obj1.groupno;
            obj.ISGROUPED = obj1.ISGROUPED;      
        end
        
    end % method
    methods(Access = protected)
        % Override copyElement method:
        function cp = copyElement(obj)
            cp = tableAgent;
            cp.table = obj.table;
            cp.colselected = obj.colselected;
            cp.rowselected = obj.rowselected;
        end
    end
    

end % classdef