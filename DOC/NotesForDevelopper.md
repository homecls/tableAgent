@import "C:\Dropbox\YY_LL\PROJECTS\Tools_Markdown\style2.less"




<!-- https://github.com/okomarov/tableutils -->



# 1 tableAgent: A chain-method table class in Matlab

<!-- TOC depthTo:3 -->

- [1 tableAgent: A chain-method table class in Matlab](#1-tableagent-a-chain-method-table-class-in-matlab)
  - [1.1 objective](#11-objective)
  - [1.2 如何调用内部函数](#12-如何调用内部函数)
  - [1.3 get 和 set override 不可以相互调用](#13-get-和-set-override-不可以相互调用)
  - [1.4 Method 尽量的返回tableAgent以方便chain-method operation](#14-method-尽量的返回tableagent以方便chain-method-operation)
  - [1.5 调用table的属性时候](#15-调用table的属性时候)
  - [1.6 label的处理](#16-label的处理)
  - [1.7 requirement](#17-requirement)

<!-- /TOC -->

> Author: linrenwen@gmail.com

## 1.1 objective

@tableAgent: create a class for applying chain method on table in Matlab

## 1.2 如何调用内部函数

``` matlab
[varargout{1:nargout}] = [builtin('subsref', obj.table, S)];
```

请注意在调用 subsref on `()` 出现了错误。所以不使用

## 1.3 get 和 set override 不可以相互调用

主要 set.properties 不要调用 get.properties，这会导致死循环。

## 1.4 Method 尽量的返回tableAgent以方便chain-method operation



## 1.5 调用table的属性时候

``` matlab
    for i=1:(length(S)-1)
        B = subsref(B, S(i));
        if istable(B) && strcmp(S(i).subs, 'table')
            B = subsasgn(B, S(i+1:end), V(:));
```
代码中`subsref(B, S(i))`调用了table的subsref的，而不是tableAgent的subsref方法。这个做法有风险：Mathwork公司，有可能关闭这一方法的访问权限。如果关闭的话，直接用`.`号调用即可。


## 1.6 label的处理

目的是为了支持UTF8/中文标题

类中主要包括两个属性
label
TcolLabel2colName

修改 label 和 TcolLabel2colName 的 Method
- getlabel
- getTcolLabel2colName
- getTcolLabelcolName2colDouble
- setLabel
- readtable
- merge
- query % no need
- disp
- headwithlabel
- stackCell

``` matlab
[varargout{1:nargout}] = [builtin('subsref', obj.table, S)];
```

请注意在调用 subsref on `()` 出现了错误。所以不使用



FIXME:
1. the `T(:,:)` are not supported



## 1.7 requirement

Matlab 2018a 2018b