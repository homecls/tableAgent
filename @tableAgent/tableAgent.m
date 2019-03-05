classdef tableAgent %< matlab.mixin.Copyable
    % ---------------------------------------------------------------
    properties (Access = public)
        % properties of data
        table
        tablename
        tableProperties
        label
        Properties
        
        
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
        % 
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
        % method function of datetype judge
        function tf = istableAgent(obj)
            tf = isa(obj,'tableAgent');            
        end
        
        % get functions
         function val = get.Properties(obj)
             %             if isempty(obj.rowselected)
             %                val = 1:height(obj.table);
             %             else
             val = obj.table.Properties;
             %             end
        end
        
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
        
        function val = get.label(obj)
            if isempty(obj.label)
               val = obj.table.Properties.VariableNames;
            else
                val = obj.label;
            end
        end
        
        
        function val = get.ISGROUPED(obj)
            if isempty(obj.ISGROUPED)
                val = false;
            else
                val = obj.ISGROUPED;
            end
        end
        
        % disp function definition
        function [obj] = disp(obj)
            [nrow,ncol] = size(obj.table);
            nrowSelected = numel(obj.rowselected);
            ncolSelected = numel(obj.colselected);
            
            fprintf('A %s class based on table\n',class(obj));
            fprintf('\tobj.ISGROUPED \t\t= %g\n',obj.ISGROUPED)
            fprintf('\tobj.rowselected \t= %g/%g\n',nrowSelected,nrow)
            fprintf('\tobj.colselected \t= %g/%g\n\n  ',ncolSelected,ncol)

            vartable = cell2table([obj.table.Properties.VariableNames; obj.label]);
            display(vartable);


           
            
            display(obj.table);
            
       end
        
        function [obj] = dispclass(obj)
            fprintf('A %s class based on table\n',class(obj));
            fprintf('\tobj.ISGROUPED \t\t= %g\n',obj.ISGROUPED)
            celldisp([obj.table.Properties.VariableNames; obj.label]);
            nrowSelected = numel(obj.rowselected);
            ncolSelected = numel(obj.colselected);
            [nrow,ncol] = size(obj.table);
            fprintf('\tobj.rowselected \t= %g/%g\n',nrowSelected,nrow)
            fprintf('\tobj.colselected \t= %g/%g\n\n  ',ncolSelected,ncol)
            display(obj.table);
        end
        
        % disp method function declare
        Tsummary = summary(obj, colstr, rowstr, colsofsummary)
        
        
        % rows cols method function declare
        rowdoble = rowstr2rowdouble(obj, idstr) % rowdouble = [1,3] rowtf=[1,0,1] rowCondition 'T.a>1'
        [coldouble, colcellstr]= colstr2coldouble(obj, strcol)
        obj = row(obj,idstr)
        obj = col(obj,strcol)
        [coldouble, colcellstr]= colstrLabel2coldouble(obj, strcol, rowno)
        obj = colbyLabel(obj,strcol)
        obj = droprow(obj,strcol)
        obj = dropcol(obj,strrow)
        obj = renamecol(obj,cololdnew)
        obj = keeprow(obj,strcol)
        obj = keepcol(obj,strrow)
        obj = blockExchange(obj,rowsA,colsA,rowsB,colsB);
        obj = gen(obj,strcmd,fn1,fn2)
        function n = height(obj)
            n = height(obj.table);
        end
        function n = width(obj)
            n = width(obj.table);
        end
        function varargout = size(obj, varargin )
            [varargout{1:nargout}] = size(obj.table,varargin{:} );
        end

        % function definion for stack
        [obj,BCell] = stackCell(obj,vnameRowColVal,rows,colsID,colsVal)
        [obj,iu] = stack(obj,vars, varargin)
        
        % merge method functions declare
         [obj,Tmerge] = merge(obj,TB,key,varargin);
         [obj,lia,TinAnotB,TinBnotA] = queryTabAinTabB(obj,keyA,valsA,TB,keyB,valsB,varargin)
         [obj,lia,TinAnotB,TinBnotA] = mergeTables(obj,keyA,valsA,TB,keyB,valsB,varargin)
         
        
        
        % for reference of class 
        % methods of . and () acess 
        tf = areParensNext(S)
        sz = numArgumentsFromSubscript(t,s,context)
               
        varargout = subsref(obj,S)
        obj = subsasgn(obj, S, V)
        [b,varargout] = subsrefDot(t,s)

        
        

        % function definion for group
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