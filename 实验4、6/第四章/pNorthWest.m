% 该程序是求解产销平衡问题初始基可行解的西北角法
% 输入项
% Demand为需求量或销量(列向量)；Supply为供应量或产地产量(列向量)
% 输出项
% X为运输分配方案;b记录了数字格(1表示对应的是基变量，数字格，0表示非基变量)


function [X,b]=pNorthWest(Supply,Demand)
m=length(Supply);
n=length(Demand);
i=1;j=1;
X=zeros(m,n);b=zeros(m,n);
while((i<=m)&&(j<=n))
    if Supply(i)<Demand(j)
        X(i,j)=Supply(i);
        b(i,j)=1;
    %%%%TODO Put the Code for Problem  at below %%%%
	%Demand需求量的变化情况
        Demand(j) = Demand(j) - Supply(i);
        i=i+1;
    else
        X(i,j)=Demand(j);
        b(i,j)=1;
    %%%%TODO Put the Code for Problem  at below %%%%
	%Supply供应量的变化情况
        Supply(i) = Supply(i) - Demand(j);
        j=j+1;
    end
end
        





