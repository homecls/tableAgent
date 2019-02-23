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
T = tableAgent;
T.name = ["Joan","Merry","Tom","Kate"]';
T.sex = ["male","female","male","female"]';
T.grade = [99,67,66,35]';
T.G = [99,67,88,55]'+ 4;
```

### generate new col or variable, by passing variable x

``` matlab
%% Test of passing variable x
para.x = [1,1]';
TB = T.row([1,2]).gen('Gx=grade + para.x',para);
```

### generate new col or variable, by passing inline-function para

``` matlab
%% Test of passing inline-function para
fnew = @(x)(x+3);
T.row().gen('G=fnew(pi)',fnew,'fnew');
T.row().gen('G2=fnew(pi)',fnew,'fnew');
```

### generate new col by group operation

``` matlab
%%  chain method demo
TB = T.row('G>=60').groupby('sex').genbygroup('SexPlus = G+1')...
    .genbygroup('SexPlus = sex+"plus"');
```

### index of table Agent

``` matlab
%% Test of assign
T{1,2:3} = [33,55];
T{1,1} = "Joan,Hi";
```

### chain-method operation

``` matlab
%%  chain method demo
TB =T.row('grade==67|grade<38').gen('grade = grade+1').gen('G = grade*2')...
    .row('grade<=99').gen('G = log(grade)*10')...
    .row([1,3]).gen('G=3')...
    .row().gen('G=pi');
```

# 1.3 requirement

Matlab 2018b