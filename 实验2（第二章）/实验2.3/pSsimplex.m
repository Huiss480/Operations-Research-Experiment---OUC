% Ssimplex.m 利用单纯形法的MATLAB程序
% max c'x
% a.t.
% ax=b
% x>=0
% 这里A\in R^{m\times n},c,x'\im R^m,b\geq 0
% 且矩阵A中有一个单位子矩阵，不需要引入人工变量
% 需要自己编程关键代码处：%%%% Put the Code for Problem  at below %%%%
function [xstar,fxstar,iter]=pSsimplex(A,b,c)
[A,b]=StMatrix(A,b);
[m,n]=size(A);
E=eye(m);
IB=zeros(1,m);
k=0;

for i = 1:m
    for j=1:n
        if A(:,j)==E(:,i)
            IB(i)=j;SA(i)=j;%IB记录基变量下标，SA记录松弛变量下标
        elseif A(:,j)==(-E(:,i))
            SA(i)=j;%SA也记录剩余变量（松弛变量）下标
        end
    end
end
A0=[b,A];
disp('显示原始单纯形表：');
disp(A0);

%消除 b c向量方向问题,都是列向量进来
[c1, c2]=size(c);
if c1==1
   c=c';
end
[b1, b2]=size(b);
if b1==1
   b=b';
end

N=1:n; %更改
N(IB)=[];
IN=N;
x(IB)=A0(:,1)';
x(IN)=zeros(1,length(IN));
disp(IB);
cB=c(IB);

%IN为非基变量下标
sigma=c'-cB'*A0(:,2:n+1);
t=length(find(sigma>0));
%计算原问题的检验数并假设检验数中有t个大于零的检验数
disp('显示检验数行sigma：');
disp(sigma);

while t~=0
    [sigma,jj]=max(sigma);
    %这里的jj是sigma中值最大者所在列，即A0中的第jj+1列（A0中的第一列为b），
    %该列对应的非基变量x(jj)为换入变量，而sigmaJ则是相应的检验数
    tt=find(A0(:,jj+1)>0);
    kk=length(tt);
    %检查增广系数矩阵A0中第jj+1列元素是否有大于零的元素
    if kk==0
        disp('原问题为无界解')
    else
        theta =zeros(1,kk);%theta列初始化为0
        %%%%TODO Put the Code for Problem  at below %%%%
        %求单纯性表的最后一列（theta值列），右端常数项b与入基变量所在列的比值
        for i=1:kk
              theta(i)=A0(tt(i),1)/A0(tt(i),jj+1);
        end
        [thetaI,ii]=min(theta);
        Temp=tt(ii);
        %比值最小的theta值，Temp是选择换出变量所在行号。 这时A0(Temp,jj+1)为旋转主元
        %Temp为旋转元行号(在A0中)，jj+1为 旋转元列号 
        disp('i=');Temp %i=i+1; 更改后检验数在最后一行
        disp('j=');jj+1 %i=i+1; 更改后检验数在最后一行
        
        %进行换基操作
        for i=1:m
            if i~=Temp
                %%%%TODO Put the Code for Problem  at below %%%%
                %%%%TODO Put the Code for Problem  at below %%%%
                %旋转元所在列其他元素都置0，其他各行的的变化
                A0(i,:)=A0(i,:)-A0(i,jj+1)/A0(Temp,jj+1)*A0(Temp,:);
            else
                %进行换基操作,旋转元元素置1，旋转元所在行的的变化
                A0(Temp,:)=A0(Temp,:)/A0(Temp,jj+1);
            end
        end
        
        TT=IB(Temp);IB(Temp)=jj;IN(jj)=TT;
        x(IB)=A0(:,1)';%基变量 
        N=1:n+m;N(IB)=[];IN=N;
        x(IN)=zeros(1,length(IN));%非基变量 
        cB=c(IB);
        %新的基可行解及其价值系数
        sigma=c'-cB'*A0(:,2:n+1);
        t=length(find(sigma>0));
        %再次计算检验数并假设检验数中有t个大于零的检验数
    end
    k=k+1;
end
%IB
%IN
% B=A(:,IB);
% InverseOfB=inv(B)

%这是基矩阵B的逆矩阵，用于灵敏度分析。若不做灵敏度分析，则将其注释掉
disp('显示最终单纯形表：')
disp(A0);
xstar=x;fxstar=x(IB)*c(IB);iter=k;


