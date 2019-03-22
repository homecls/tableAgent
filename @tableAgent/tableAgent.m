classdef tableAgent %< matlab.mixin.Copyable
    % ---------------------------------------------------------------
    properties (Access = public)
        % properties of data
        table
        tablename
        tableProperties
        label
        TcolLabel2colName


        Properties
        
        
        rowselected
        colselected
        variablestored
        ISGROUPED
        groupid
        groupno
        groupvar
        


        % properties of id
        %idnames
        %id
        %id1
        %id2
        %id3
        
        %properties of time
        
        %time
        %datenumOrg
        %datenum
        %datenumEom
        %datestr
        %datetime
        %frequency
        %istimeContinuous
        
        % properties of panel
        %isbalanced
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
                obj.groupvar = {''};
                obj.label = table;
            else
                obj.table = Tab;
                obj.tablename = inputname(1);
                obj.tableProperties = Tab.Properties;
                obj.rowselected = true(height(Tab),1);
                obj.groupvar = {''};
                obj.label = table;
                
            end
        end
        % method function of datetype judge
        function tf = istableAgent(obj)
            tf = isa(obj,'tableAgent');            
        end
        
        % get functions
         function val = get.Properties(obj)
             val = obj.table.Properties;
        end
        
        function val = get.rowselected(obj)
            if isempty(obj.rowselected) || height(obj.table) < numel(obj.rowselected)
               val = true(height(obj.table),1);
            else
                val = obj.rowselected;
            end
        end
        
        function val = get.colselected(obj)
            if isempty(obj.colselected) || width(obj.table) < numel(obj.colselected)
               val = true(width(obj.table),1);
            else
                val = obj.colselected;
            end
        end
        
        function val = get.label(obj)
            TnameMap = obj.TcolLabel2colName;
            TnameMap.Row = TnameMap.Name;
            val = TnameMap{obj.table.Properties.VariableNames,'Label'};
%             if isempty(obj.label)
%                val = obj.table.Properties.VariableNames; % FIXME: cellstr or table?
%             else
%                 val = obj.label;
%             end
        end

        function val = get.TcolLabel2colName(obj)
            colName = (obj.table.Properties.VariableNames)';
            if isempty(obj.TcolLabel2colName)
                % table for colname collabel are empty
                colLabel = colName;
                obj.TcolLabel2colName = table(colName,colLabel,'VariableNames',{'Name','Label'});
            
            elseif ~(height(obj.TcolLabel2colName) == obj.width)
                % table for colname collabel need to be adjusted
                TcolLabel2colNameOld = obj.TcolLabel2colName;
                colLabel = colName;
                TcolLabel2colNameNew = table(colName,colLabel,'VariableNames',{'Name','Label'});
                obj.TcolLabel2colName = queryTabAinTabB(TcolLabel2colNameNew, TcolLabel2colNameOld,'Name', 'Name', 'Label','Label');
            else
                TcolLabel2colNameOld = obj.TcolLabel2colName;
                colLabel = colName;
                TcolLabel2colNameNew = table(colName,colLabel,'VariableNames',{'Name','Label'});
                TcolLabel2colName = queryTabAinTabBQuiet(TcolLabel2colNameNew, TcolLabel2colNameOld,'Name', 'Name', 'Label','Label');
                obj.TcolLabel2colName = TcolLabel2colName;
                % do nothing the demension col is the same
            end
            obj.TcolLabel2colName.Row = obj.TcolLabel2colName.Name;
            val = obj.TcolLabel2colName(colName,:);
        end

%         function obj = set.label(obj, val)
% 
% %             if isempty(obj.label)
% %                obj.label = obj.table.Properties.VariableNames; % FIXME: cellstr or table?
% %             else
%                obj.label = val;
% %             end
% %             obj.label = val;
%         end
        
%         function obj = set.TcolLabel2colName(obj, val)
%             %TcolnamecollabelOld = obj.TcolLabel2colName;
%             TcolnamecollabelNew = val;
%             if isempty(obj.TcolLabel2colName)
%                obj.TcolLabel2colName = TcolnamecollabelNew; % FIXME: cellstr or table?
%             else
%                 obj.TcolLabel2colName = TcolnamecollabelNew;
%             end
% %             obj.TcolnamecollabelNew = val;
%         end
        
        
        function val = get.ISGROUPED(obj)
            if isempty(obj.ISGROUPED)
                val = false;
            else
                val = obj.ISGROUPED;
            end
        end
        
        % function definition: disp
        function obj = disp(obj)
            display(obj.table);
            % obj = obj.table;
        end
       
        
        % function definition: dispclass 
        function [obj] = dispclass(obj)
            cprintf('blue','\n\tA %g¡Á%g "%s" class, based on table\n',obj.height,obj.width, class(obj));
            fprintf('\tobj.ISGROUPED \t\t= %g\n',obj.ISGROUPED)
            fprintf('\tobj.groupvar \t\t= %s\n',strjoin(obj.groupvar,';' ))
            [nrow,ncol] = size(obj.table);
            nrowSelected = numel(obj.rowselected);
            ncolSelected = numel(obj.colselected);
            fprintf('\tobj.rowselected \t= %g/%g\n',nrowSelected,nrow)
            fprintf('\tobj.colselected \t= %g/%g\n\n  ',ncolSelected,ncol)
            
            cprintf('blue','\n\tcolumns'' name and their labels are: \n',obj.ISGROUPED)
            % disp(cell2table([obj.table.Properties.VariableNames; obj.label.(1)]));
            disp(obj.label);
            
            cprintf('blue','\n\tThe Data of obj.table\n');
            disp(obj.table);
        end
        
        function [obj] = dispBasicProperties(obj)
            cprintf('blue','\n\tA %g¡Á%g "%s" class, based on table\n',obj.height,obj.width, class(obj));
            fprintf('\tobj.ISGROUPED \t\t= %g\n',obj.ISGROUPED)
            fprintf('\tobj.groupvar \t\t= %s\n',strjoin(obj.groupvar,'; '))
            [nrow,ncol] = size(obj.table);
            nrowSelected = numel(obj.rowselected);
            ncolSelected = numel(obj.colselected);
            fprintf('\tobj.rowselected \t= %g/%g\n',nrowSelected,nrow)
            fprintf('\tobj.colselected \t= %g/%g\n\n  ',ncolSelected,ncol)
            
            cprintf('blue','\n\tcolumns'' name and their labels are: \n',obj.ISGROUPED)
            % disp(cell2table([obj.table.Properties.VariableNames; obj.label.(1)]));
            disp(obj.label);
            
            % cprintf('blue','\n\tThe Data of obj.table\n');
            % disp(obj.table);
        end

        % function for size and numel
        function n = height(obj)
            n = height(obj.table);
        end
        function n = width(obj)
            n = width(obj.table);
        end
        function n = numel(obj)
            n = numel(obj.table);
        end
%         function varargout = size(obj, varargin )
%             [varargout{1:nargout}] = size(obj.table,varargin{:} );
%         end
        
        % Function declare: summary method 
        Tsummary = summary(obj, colstr, rowstr, colsofsummary)
        
        
        % Function declare: rows cols method
        rowdoble = rowstr2rowdouble(obj, idstr) % rowdouble = [1,3] rowtf=[1,0,1] rowCondition 'T.a>1'
        [coldouble, colcellstr]= colstr2coldouble(obj, strcol)
        [obj]= head(obj,nrow)
        [C]= headwithLabel(obj,nrow)
        [obj]= tail(obj,nrow)
        [obj, rowselected]= row(obj,idstr)
        obj = col(obj,strcol)
        [coldouble, colcellstr]= colstrLabel2coldouble(obj, strcol, rowno)
        [coldouble, colcellstr]= colRaw2colDouble(obj, strcol)
        obj = colbyLabel(obj,strcol)
        obj = droprow(obj,strcol)
        obj = dropcol(obj,strrow)
        obj = renamecol(obj,cololdnew)
        obj = keeprow(obj,strcol)
        obj = keepcol(obj,strrow)
        obj = blockExchange(obj,rowsA,colsA,rowsB,colsB);
        obj = blockCopy(obj,rowsA,colsA,rowsTarge,colsTarget)
        [obj, index] = sortrows(obj,col,varargin)
        
       % generate or update cols 
        obj = gen(obj,strcmd,fn1,fn2)
        obj = gen_slice(obj,coly,ifthenGen) % support otherwise
        obj = gen_dummy (obj, tableVariable)
        
        obj = gen_forEachCol(obj,colsx,genstr,colsnew)

        [obj,cmdstrFull] = runCmdGen(obj,cmdstr)
        
        % missing data
        % fillmissing
        

        % function definion for group
        obj = groupby(obj,colstr,coly,fn,colx)
        obj = genbygroup(obj,cmdstr,FNHANDLE_TEMP_,fname,varargin)


        % Function declare: stack
        [obj,BCell] = stackCell(obj,vnameRowColVal,rows,colsID,colsVal)
        [obj,iu] = stack(obj,vars, varargin)
        [obj,objUnstack] = pivot(obj,colAandB,colVal,fn)
        
        % Function declare: merge
         [obj,Tmerge] = merge(obj,TB,key,varargin);
         [obj,Tmerge] = mergeWithLabel(obj,TB,key,varargin);
         %[obj,lia,TinAnotB,TinBnotA] = queryTabAinTabB(obj,keyA,valsA,TB,keyB,valsB,varargin)
         [obj,lia,TinAnotB,TinBnotA] = queryTabAinTabB(obj,TabB,keyA,keyB,valsA,valsB,varargin)
         [obj,lia,TinAnotB,TinBnotA] = mergeTables(obj,keyA,valsA,TB,keyB,valsB,varargin)
         
         % function declare: plotcols
         obj = plotcols(obj,cols,varargin)
         obj = plotcolsNumber(obj,cols,varargin)
         
        % Function declare: utility for tableAgent
        [obj,cmdstrfull] = cmdstrStandardize(obj, cmdstr);
        
        % Function declare: for reference of class and index
        % methods of . and () acess 
        tf = areParensNext(S)
        [varargout] = subsrefParens(a,s)
        sz = numArgumentsFromSubscript(t,s,context)
               
        varargout = subsref(obj,S)
        obj = subsasgn(obj, S, V)
        [b,varargout] = subsrefDot(t,s)
        S = shiftS(S,n)
        S = rowRaw2rowdoubleTableAgent(obj,S)
        %tf = areParensNext(S)
        
        %% Appendixs (FIXME:)
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