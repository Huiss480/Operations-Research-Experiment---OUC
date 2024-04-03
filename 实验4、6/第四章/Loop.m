%该程序是调整运输方案的闭回路法。根据给定的入基变量,确定退出基并将运输分配方案进行更新。
%输入项
%X:当前运输分配方案(m*n矩阵);b:基变量标志矩阵,基1对应数字格,0对应空格(m*n矩阵);
%row,co1:入基的行标和列标。
%输出项
%Y:更新后的运输分配方案(m*n矩阵);bout:更新后的新基变量(m*n矩阵,意义和形式同b)。
% 更正错误
function [Y,bout]=Loop(X,row,col,b)
bout=b;
Y=X;
[m,n]=size(X);
loop=[row,col];
X(row,col)=Inf;
b(row,col)=Inf;
rowsearch=1; %开始进行闭回路的搜索。

while(loop(1,1)~=row || loop(1,2)~=col || length(loop)==2)
if rowsearch%开始闭回路的行搜索。
    j=1;
    while rowsearch
        if(b(loop(1,1),j)~=0)&&(j~=loop(1,2))
            loop=[loop(1,1) j;loop];%加入构成闭回路的指标。
            rowsearch=0;%开始闭回路的列搜索。
        elseif j==n,
            b(loop(1,1),loop(1,2))=0;
            loop=loop(2:length(loop),:);%回溯。
            rowsearch=0;
        else
            j=j+1;
        end
    end
else %列搜索(也可能从列开始搜索)。
    i=1;
    while ~rowsearch
        if(b(i,loop(1,2))~=0)&&(i~=loop(1,1))
            loop=[i loop(1,2);loop];
            rowsearch=1;
        elseif i==m
            b(loop(1,1), loop(1,2))=0;
            loop=loop(2:length(loop),:);
            rowsearch=1;
        else
            i=i+1;
        end
    end
end
end
l=length(loop); %％这里计算调整量。
%disp(l)
theta=Inf;
minindex=Inf;
for i=2:2:l
    if X(loop(i,1),loop(i,2))<theta
        theta=X(loop(i,1),loop(i,2));
        minindex=i;
    end;
end

%disp('Before disp(Y)：');
%disp(Y);
Y(row,col)=theta;%％计算新的运输分配方案（矩阵）。
for i=2:l-1
    Y(loop(i,1),loop(i,2))=Y(loop(i,1),loop(i,2))+(-1)^(i-1)*theta;
end
bout(row,col)=1;
%disp('After disp(Y)：');
%disp(Y);
bout(loop(minindex,1),loop(minindex,2))=0;
