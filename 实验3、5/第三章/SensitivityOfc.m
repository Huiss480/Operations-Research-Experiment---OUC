% 线性规划的灵敏度分析
% 该程序要论价值系数 c变化时是否影响原问题的最优解，若最优解改变，
% 则求出新的最优解
% 线性规划需要化成标准形式才能使用，即
% max c'x
% s.t.
% Ax=b
% x>=0
% 这里A\in R^{m\times n},c,x'\in R^n,b\in R^m, b\geq 0
% 讨论价值系数的变化时针对的是未化为标准形式前的原变量的价值系数，
% 不包括松弛变量和剩余变量的价值系数（全部为零）
%  By Gongnong Li 2013
function[UOfDeltac,LOfDeltac]=SensitivityOfc(A,b,c)
% 首先调用SenSimplex.m 计算该线性规划问题，将得到所需的相关信息
[m,n]=size(A);
[IB,IN,SA,IBB,INN,InverseOfB,A0,sigma]=SenSimplex(A,b,c)
% IB记录的是基变量下标，IN记录的是非基变量下标，SA记录的是松弛变量下标
% IBB记录的是除去松弛变量后的基变量下标，INN记录的除去松弛变量后的非基变量下标
disp('以上显示的是原问题的最优解(xstar)，最优值(fxstar)，迭代次数(iter)，最优基下标(IB)等信息。')
for r=1:length(IN)
    UOfDeltac(IN(r))=-sigma(IN(r));LOfDeltac(IN(r))=-inf;
end
%这里讨论的是非基变量的价值系数变化(Deltac)的上、下限
%下面讨论的是基变量价值系数变化的上、下限
for r=1:length(IB)
    t1=find(A0(r,IN+1)<0);t2=find(A0(r,IN+1)>0);
    if length(t2)~=0
        for i=1:length(t2)
            b1(i)=sigma(IN(t2(i)))/A0(r,IN(t2(i))+1);
        end
        [LOfDeltac(IB(r)),U1]=max(b1);
    else
        LOfDeltac(IB(r))=-inf;
    end
    if length(t1)~=0
        for i=1:length(t1)
            b2(i)=sigma(IN(t1(i)))/A0(r,IN(t1(i))+1);
        end
        [UOfDeltac(IB(r)),U2]=min(b2);
    else
        UOfDeltac(IB(r))=inf;
    end
end
n0=input('输入原始变量的个数');
for i=1:n0
    disp(['c' num2str(i) '的当前值为' num2str(c(i)) ', 变化范围为[' ...
        num2str(c(i)+LOfDeltac(i)) ',' num2str(c(i)+UOfDeltac(i)) ']' ])
end
Deltac=input('按照列向量输入价值系数的变化（一次只能有一个c变化且输入的应该是Deltac）')
D=find(Deltac~=0);ctemp2=c+Deltac;
if(Deltac(D)>=LOfDeltac(D))&(Deltac(D)<=UOfDeltac(D))
    disp('最优基(IB)不变，最优解(xstar)也不变，最优值(fxstar)变为：')
    IB,xstar(IB)=A0(:,1)',fxstar=xstar(IB)*ctemp2(IB)
else
    disp('最优基改变。最优基变量下标(IB)、最优解(xstar)及最优值(fxstar)变为：')
    c(D)=c(D)+Deltac(D);
    [IB,IN,SA,IBB,INN,InverseOfB,A0]=SenSimplex(A0(:,2:n+1),A0(:,1),c)
end
    
    
    
    
    