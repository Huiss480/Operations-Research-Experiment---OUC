% 线性规划的灵敏度分析
% 该程序讨论资源向量b有变化时(获得改变Deltab)是否影响线性规划的最优解
% 若最优解改变，则求出新的最优解
% 线性规划需要化成标准形式才能使用，即
% max c'x
% s.t.
% Ax=b
% x>=0
% 这里A\in R^{m\times n},c,x'\in R^n,b\in R^m, b\geq 0
% 讨论价值系数的变化时针对的是未化为标准形式前的原变量的价值系数，
% 不包括松弛变量和剩余变量的价值系数（全部为零）
%  By Gongnong Li 2013
function[UOfDeltab,LOfDeltab]=SensitivityOfb(A,b,c)
% 首先调用SenSimplex.m 计算该线性规划问题，将得到所需的相关信息
[m,n]=size(A);
[IB,IN,SA,IBB,INN,InverseOfB,A0,sigma]=SenSimplex(A,b,c)
% IB记录的是基变量下标
% IBB记录的是除去松弛变量后的基变量下标，INN记录的除去松弛变量后的非基变量下标
disp('以上显示的是原问题的最优解(xstar)，最优值(fxstar)，迭代次数(iter)，最优基下标(IB)等信息。')
for r=1:m
    t1=find(InverseOfB(:,r)<0);t2=find(InverseOfB(:,r)>0);
    if length(t1)~=0
        for i=1:length(t1)
            b1(i)=-A0(t1(i),1)/InverseOfB(t1(i),r);
        end
        [UOfDeltab(r),U1]=min(b1);
    else
        UOfDeltab(r)=inf;
    end
    if length(t2)~=0
        for i=1:length(t2)
            b2(i)=-A0(t2(i),1)/InverseOfB(t2(i),r);
        end
        [LOfDeltab(r),U2]=max(b2);
    else
        LOfDeltab(r)=-inf;
    end
end
for i=1:length(b)
    disp(['b' num2str(i) '的当前值为' num2str(b(i)) ', 变化范围为[' ...
        num2str(b(i)+LOfDeltab(i)) ',' num2str(b(i)+UOfDeltab(i)) ']' ])
end
Deltab=input('按照列向量输入资源系数的变化（一次只能有一个b变化且输入的应该是Deltab）')
D=find(Deltab~=0);
if(Deltab(D)>=LOfDeltab(D))&(Deltab(D)<=UOfDeltab(D))
    disp('最优基(IB)不变，最优解(xstar)也不变，最优值(fxstar)变为：')
    A0(:,1)=A0(:,1)+InverseOfB*Deltab;
    IB,xstar(IB)=A0(:,1)',fxstar=xstar(IB)*c(IB)
else
    disp('最优基改变。最优基变量下标(IB)、最优解(xstar)及最优值(fxstar)变为：')
    A0(:,1)=A0(:,1)+InverseOfB*Deltab;
    DD=find(A0(:,1)<0);
    if length(DD)~=0
        [xstar,fxstar,A0,IB,iter]=Dsimplex(A0(:,2:n+1),A0(:,1),c)
    else
        [IB,IN,SA,IBB,INN,InverseOfB,A0,sigma]=SenSimplex(A0(:,2:n+1),A0(:,1),c)
    end
end







