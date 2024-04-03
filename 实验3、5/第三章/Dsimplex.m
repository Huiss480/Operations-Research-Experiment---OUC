% Dsimplex.m 对偶单纯形法求解线性规划问题
% max c'x
% s.t.
% Ax=b
% x>=0
% 这里A\in R^{m\times n},c,x'\in R^n,b\in R^m
% 矩阵A中有一个单位子矩阵，不需要引入人工变量。非基变量检验数满足最优性规则，但资源向量有负值
%  By Gongnong Li 2013
function[xstar,fxstar,A0,IB,iter]=Dismplex(A,b,c)
[m,n]=size(A);E=eye(m);IB=zeros(1,m);k=0;
for i=1:m
    for j=1:n
        if A(:,j)==E(:,i)
            IB(i)=j;SA(i)=j; % IB记录基变量下标，SA记录松弛变量下标
        elseif A(:,j)==(-E(:,i))
            SA(i)=j; % SA也记录剩余变量(松弛变量)下标
        end
    end
end
A0=[b,A];N=1:n;IB;N(IB)=[]; IN=N;x(IB)=A0(:,1)';
x(IN)=zeros(1,length(IN)); cB=c(IB);
%IN为非基变量下标
sigma=c'-cB' * A0(:,2:n+1);
%计算检验数，由于对偶单纯形法的要求，这里sigma全部小于或等于零
t=find(A0(:,1)<0); %检查b列的负数
flag=0;
while (t~=0)&(flag==0)
    [bjj,jj]=min(A0(:,1));
% 这里的jj是A0(:,1)中绝对值最大者所在行，即A0中的第jj行，该行对应的基变量
% x(IB(jj))为换出变量，而bjj则是相应的数值
tt=find(A0(jj,2:n+1)<0);kk=length(tt);
% 检查增广系数矩阵A0中第jj行元素是否有小于零的元素
        if kk==0
            disp('原问题无解')
            xstar=[];fxstar=[];A0=[];IB=[];iter=k;
            flag=1;
        else
            theta=zeros(1,kk);
            for i=1:kk
                theta(i)=sigma(tt(i))/A0(jj,tt(i)+1);
            end
            [thetaI,ii]=min(abs(theta));Temp=tt(ii);
% 比值最小的theta值，选换出变量。这时x(Temp)为换入变量。A0(jj,Temp+1)为旋转主元
            for i=1:m
                if i ~=jj
                    A0(i,:)=A0(i,:)-(A0(jj,:)/A0(jj,Temp+1))*A0(i,Temp+1);
                else
                    A0(jj,:)=A0(jj,:)/A0(jj,Temp+1);
                end
            end
            TT=IB(jj);IB(jj)=Temp;IN(Temp)=TT;x(IB)=A0(:,1)';
            N=1:n;N(IB)=[];IN=N;x(IN)=zeros(1,length(IN));cB=c(IB);
% 新的基可行解及其价值系数
            t=find(A0(:,1)<0);sigma=c'-cB'*A0(:,2:n+1);
% 再次检查b列的负数并再次计算检验数
        end
        k=k+1;
end
disp('最优基变量下标为： '),IB
disp('非基变量下标为：'),IN
disp('最终单纯性表为（第一列为资源向量）：'),A0
disp('最终单纯性表中的检验数：'),sigma
if flag==1
    xstar=[];fxstar=[];iter=k;
    disp('原问题无界解')
else
    B=A(:,IB);
    xstar=x;fxstar=x(IB)*c(IB);iter=k;
end

% 测试用例
% A=[-1 -2 -1 1 0;-2 1 -3 0 1];
% b=[-3 -4]';
% c=[-2 -3 -4 0 0]';
% [xstar,fxstar,A0,IB,iter]=Dsimplex(A,b,c)    
    

                     
                    
           

            

