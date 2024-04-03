% 该程序是求解产销平衡问题初始基可行解的伏格尔法
% 输入项
% Cost为单位运费表(矩阵)，行对应产地，列对应销地
% Supply为供应量或产地产量(列向量)；Demand为需求量或销量(列向量)
% 输出项
% X为运输分配方案;b记录了数字格(1表示对应的是基变量，数字格，0表示非基变量)
% By Gongnong Li 2013
function [X,b]=Vogal(Cost,Supply,Demand)
[m,n]=size(Cost);  m=length(Supply);n=length(Demand);
X=zeros(m,n);b=zeros(m,n);I=[1:m];
flag=0;
while flag==0
    TRC=Cost;TCC=Cost;
    for k=1:m %求出每行最小元素和次最小元素的列标J1(k)和J2(k)
        [T1(k),J1(k)]=min(TRC(k,:));
        TRC(k,J1(k))=inf;
        [T2(k),J2(k)]=min(TRC(k,:));
    end
    for s=1:n %求出每列最小元素和次最小元素的列标JJ1(s)和JJ2(s)
         [TT1(s),JJ1(s)]=min(TCC(:,s));
         TCC(JJ1(s),s)=inf;
         [TT2(s),JJ2(s)]=min(TCC(:,s));
    end
    % 求出每行(列)最小元素和次最小元素的差额并求出其中最大者
    for i=1:m
        if (T2(i)==inf)&(T1(i)~=inf)
            Trow(i)=T1(i);
        elseif T2(i)==inf
            Trow(i)=-inf;
        else
            Trow(i)=T2(i)-T1(i);
        end
    end
    for i=1:n
        if (TT2(i)==inf)&(TT1(i)~=inf)
            Tcolumn(i)=TT1(i);
        elseif TT2(i)==inf
            Tcolumn(i)=-inf;
        else
            Tcolumn(i)=TT2(i)-TT1(i);
        end
    end
    [TrowM,kk1]=max(Trow);[TcolumnM,kk2]=max(Tcolumn);
    %差额最大者在kk1行，该行最小元素为第J1(kk1)个元素
    if((TrowM>TcolumnM) | (TrowM==TcolumnM))
        kk=kk1;Jkk=J1(kk1);
    else %差额最大者在列，该列最小元素最小者为第JJ1(kk1)个元素
        kk=JJ1(kk2);Jkk=kk2;
    end
    %这样，X(kk,J(kk))元素是分配矩阵中优先考虑安排的元素
    %于是考虑Supply(kk)与Demand(J(kk))之间的关系并安排运输方案。
    %若第Jkk个销地的销量超过第kk个产地的产量，则
    %将第kk个产地的产量Supply(kk)全部供应给第Jkk个销地，然后将Cost中的第kk
    %行划去(通过赋值inf完成)。若第kk个产地的产量超过第Jkk个销地的销量，
    %则第kk个产地的产量全部满足第Jkk个销地。然后将Cost中的第Jkk列划去(通过赋值inf完成)
     if Supply(kk)<Demand(Jkk)
        X(kk,Jkk)=Supply(kk);        
        Demand(Jkk)=Demand(Jkk)-Supply(kk);
        Supply(kk)=0;
        b(kk,Jkk)=1;
        Cost(kk,:)=inf*ones(1,n);
    elseif Supply(kk)>Demand(Jkk)
        X(kk,Jkk)=Demand(Jkk);        
        Supply(kk)=Supply(kk)-Demand(Jkk);
        Demand(Jkk)=0;
        b(kk,Jkk)=1;
        Cost(:,Jkk)=inf*ones(m,1);
    else
        X(kk,Jkk)=Demand(Jkk);
        b(kk,Jkk)=1;
        % 这时出现退化情况，需要补0作为某个基变量的取值
        Supply(kk)=0;
        Demand(Jkk)=0;
        Cost(:,Jkk)=inf*ones(m,1);
        Cost(kk,:)=inf*ones(1,n);
        if (length(find(b==1))==(m+n-1))
            flag=1;
        else
            I=find(I~=Jkk);
            if length(I)~=0
                b(I(1),Jkk)=1;
            else
                return;
            end
        end
     end
     if (length(find(b==1))==(m+n-1))
         flag=1;
     else
         flag=0;
     end
end

         
          
        
        
           
          
    
    
            
        
        
        
        
        
        
        
        
        
        
        