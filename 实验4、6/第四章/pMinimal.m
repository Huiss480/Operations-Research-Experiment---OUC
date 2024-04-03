% 该程序是求解产销平衡问题初始基可行解的最小元素法
% 输入项
% Cost为单位运费表(矩阵)，行对应产地，列对应销地
% Supply为供应量或产地产量(列向量)；Demand为需求量或销量(列向量)
% 输出项
% X为运输分配方案;b记录了数字格(1表示对应的是基变量，数字格，0表示非基变量)

function [X,b]=pMinimal(Cost,Supply,Demand)
[m,n]=size(Cost); 
m=length(Supply);
n=length(Demand);
X=zeros(m,n);b=zeros(m,n);I=[1:m];
flag=0;
while flag==0
    for k=1:m
        [T(k),J(k)]=min(Cost(k,:));
    end
    [TT,kk]=min(T);
    %Cost(kk,J(kk))元素是Cost中最小者。于是考虑Supply(kk)与Demand(J(kk))之
    %间的关系并安排运输方案。若第J(kk)个销地的销量超过第kk个产地的产量，则
    %将第kk个产地的产量Supply(kk)全部供应给第J(kk)个销地，然后将Cost中的第kk
    %行划去(通过赋值inf完成)。若第kk个产地的产量超过第J(kk)个销地的销量，
    %则第kk个产地的产量全部满足第J(kk)个销地。然后将Cost中的第J(kk)列划去(通过赋值inf完成)
    if Supply(kk)<Demand(J(kk))
        X(kk,J(kk))=Supply(kk);   
    %%%%TODO Put the Code for Problem  at below %%%%
	%Demand需求量的变化情况 Supply供应量的变化情况
        Demand(J(kk)) = Demand(J(kk)) - Supply(kk);
        Supply(kk) = 0;
        
        b(kk,J(kk))=1;
        Cost(kk,:)=inf*ones(1,n);
    elseif Supply(kk)>Demand(J(kk))
        X(kk,J(kk))=Demand(J(kk));  
    %%%%TODO Put the Code for Problem  at below %%%%
	%Demand需求量的变化情况 Supply供应量的变化情况
        Supply(kk) = Supply(kk) - Demand(J(kk));
        Demand(J(kk)) = 0;
        
        b(kk,J(kk))=1;
        Cost(:,J(kk))=inf*ones(m,1);
    else
        X(kk,J(kk))=Demand(J(kk));
        b(kk,J(kk))=1;
        % 这时出现退化情况，需要补0作为某个基变量的取值
        Supply(kk)=0;Demand(J(kk))=0;Cost(:,J(kk))=inf*ones(m,1);Cost(kk,:)=inf*ones(1,n);
        % 为了防止多补0作为某个基变量的取值，作如下处理
        if length(find(b==1))<m+n-2
            I1=find(I~=kk);b(I1(end),J(kk))=1;
        end
    end
    if length(find(b==1))==m+n-1
        flag=1;
    else
        flag=0;
    end
end

