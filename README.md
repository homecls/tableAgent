@import "C:\Dropbox\YY_LL\PROJECTS\Tools_Markdown\style2.less"

<!-- https://github.com/okomarov/tableutils -->

# tableAgent: A chain-method table class in Matlab



> Author: linrenwen@gmail.com

# 1.1 objective

@tableAgent: create a class for applying chain method on table in Matlab

# 1.2 usage

>See ./tableAgent_test.m for List of features.

### data construction
``` matlab
T = table;
T.name = ["Joan","Merry","Tom"]';
T.grade = [99,67,35]';

Tagent = tableAgent(T);
```

### generate new col or variable, by passing variable x
``` matlab
%% Test of passing variable x
para.x = [1,1]';
Tagent.row([1,2]).gen('Gx=grade + para.x',para);
disp(Tagent.table)
return
```

### generate new col or variable, by passing inline-function para

``` matlab
%% Test of passing inline-function para
fnew = @(x)(x+3);
Tagent.row().gen('G=fnew(pi)',fnew,'fnew');
Tagent.row().gen('G2=fnew(pi)',fnew,'fnew');
```

### index of table Agent

``` matlab
%% Test of assign
Tagent{1,2:3} = [33,55];
Tagent{1,1} = "Joan,Hi";
disp(Tagent.table)
```


### chain-method operation

``` matlab
%%  chain method demo
Tagent.row('grade==67|grade<38').gen('grade = grade+1').gen('G = grade*2')...
    .row('grade<=99').gen('G = log(grade)*10')...
    .row([1,3]).gen('G=3')...
    .row().gen('G=pi');
```

# 1.3 requirement

Matlab 2018b