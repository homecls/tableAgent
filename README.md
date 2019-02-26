@import "C:\Dropbox\YY_LL\PROJECTS\Tools_Markdown\style2.less"




<!-- https://github.com/okomarov/tableutils -->



# tableAgent: A chain-method table class in Matlab

<!-- TOC depthTo:2 -->

- [tableAgent: A chain-method table class in Matlab](#tableagent-a-chain-method-table-class-in-matlab)
  - [1.1 objective](#11-objective)
  - [1.2 Install](#12-install)
  - [1.3 usage](#13-usage)
  - [1.4 requirement](#14-requirement)

<!-- /TOC -->

> Author: linrenwen@gmail.com

## 1.1 objective

@tableAgent: create a class for applying chain method on table in Matlab

## 1.2 Install

1. unzip the `tableAgent_test.zip`. copy the files in `functions` fold inside zip file
2. run `tableAgent_test.m` for  examples.

## 1.3 usage

>See `tableAgent_test.m` for List of features.

### data construction

``` matlab
%% data construction method 1
T = tableAgent;
T.name = ["Joan","Merry","Tom","Kate"]';
T.sex = ["male","female","male","female"]';
T.grade = [99,67,66,35]';
T.G = [99,67,88,55]'+ 4;

%% data construction method 2
T = table;
T.name = ["Joan","Merry","Tom",
TB = tableAgent(T);
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
TB = T.row().gen('G=fnew(pi)',fnew,'fnew');
TB = T.row().gen('G2=fnew(pi)',fnew,'fnew');
```

### generate new col by group operation

``` matlab
%%  chain method demo
TB = T.row('G>=60').groupby('sex').genbygroup('SexPlus = G+1')...
    .genbygroup('SexPlus = sex+"plus"');
```

### test of dropcols and droprows

``` matlab
TB = T.row([1,2]).droprow('G==71');
TB = T.keeprow([1,3,4]);
TB = T.dropcol(2).row(3).droprow().keepcol('name,G');

TB = T.droprow('G==71');
TB = T.row(1).droprow()
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

### disp

``` matlab
%% test of disp
T = T.row([1,2]);
T.gen('G=2').dispclass;
dispclass(T);
disp(T);
disp(T.table);
``` 

## 1.4 requirement

Matlab 2018b