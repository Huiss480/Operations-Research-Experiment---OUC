%求解整数线性规划的分支定界法，可求解如下形式的全整数线性或混合整数线性规划问题
%max c'x
%s.t.
%Ax<=b,Aeq x=beq.
%lb<=x<=ub.
%x为整数或部分整数决策列向量
%本程序调用MATLAB自带的linprog命令求解每次的松弛问题，问题形式的linprog的要求相同
%调用格式
%[xstar,fxstar,iter]=BranchBound(c,A,b)
%[xstar,fxstar,iter]=BranchBound(c,A,b,Aeq,beq)
%[xstar,fxstar,iter]=BranchBound(c,A,b,Aeq,beq,lb,ub)
%[xstar,fxstar,iter]=BranchBound(c,A,b,Aeq,beq,lb,ub,x0)
%[xstar,fxstar,iter]=BranchBound(c,A,b,Aeq,beq,lb,ub,x0,I)
%[xstar,fxstar,iter]=BranchBound(c,A,b,Aeq,beq,lb,ub,x0,I,options)
%其中，输出项:
%xstar为最优解列向量；fxstar为目标函数最小值；slack为松弛(剩余)变量
%输入项：c为目标函数价值系数向量；A为不等式约束系数矩阵；b为不等式约束条件右端列
%向量;Aeq为等式约束条件系数矩阵；beq为等式约束条件右端列
%lb为决策变量下界列向量；ub为决策变量上届列向量
%x0为迭代值(可缺省);I为整数变量指标列向量，1表示整数，0表示实数
%options的设置请参见optimset或linprog

function [xstar,fxstar,iter]=pBranchBound(c,A,b,Aeq,beq,lb,ub,x0,I,options)
global  z2 opt c1 x01 A1 b1 Aeq1 beq1 I options iter;
[m1,n1]=size(A);
[m2,n2]=size(Aeq);
iter=1;
if nargin<10
    options=optimset({});
    options.Display='off';
    options.LargeScale='on';
end
if nargin<9
    I=ones(size(c));
end
if nargin<8
    x0=[];
end
if nargin<7|isempty(ub)
    ub=inf*ones(size(c));
end
if nargin<6|isempty(lb)
    lb=zeros(size(c));
end
if nargin<5
    beq=[];
end
if nargin<4
    Aeq=[];
end
z2=inf;c1=c;x01=x0;A1=A;b1=b;Aeq1=Aeq;beq1=beq;I=I;
z1=BranchBound1(lb(:),ub(:));
xstar=opt;
[mm,nn]=size(xstar);
fxstar=-z2;
if mm>1
    disp('最优解有多个（xstar矩阵每行对应一组最优解）以及最优目标函数值fxstar、迭代次数（iter）为：')
else
    disp('最优解xstar以及最优目标函数值fxstar、迭代次数(iter为)：')
end
%以下为上面程序需要调用的子函数
function z1=BranchBound1(vlb,vub)
global  z2 opt c1 x01 A1 b1 Aeq1 beq1 I options iter;
[x,z1,exitflag]=linprog(-c1,A1,b1,Aeq1,beq1,vlb,vub,x01,options);
if exitflag<=0
    return
end
if z1-z2>1e-3
    return
end

if max(abs(x.*I-round(x.*I)))<1e-3
    %%%%TODO Put the Code for Problem  at below %%%%
    %比较最优值的大小，判断更小的最优值可能出现的范围
    if (z2 - z1)>1e-3
        opt=x';
        disp('----------------------------');
        disp('前z2:');
        disp(z2);
        disp('z1:');
        disp(z1);
        z2=z1;
        disp('后z2:');
        disp(z2);
        return
    else
        opt=[opt;x'];
        return
    end
end
notintx=find(abs(x-round(x))>1e-3);
intx=fix(x);%比x小的整数
tempvlb=vlb;tempvub=vub;

disp('++++++++++++++++++');
disp('vub：');
disp(vub);
disp('vlb：');
disp(vlb);
disp('notintx:');
disp(notintx);
%分支定界 整数
if vub(notintx(1,1),1)>=intx(notintx(1,1),1)+1
    tempvlb(notintx(1,1),1)=intx(notintx(1,1),1)+1;%分支 取更小值出现的范围
    %%%%TODO Put the Code for Problem  at below %%%%
    %递归调用BranchBound1分支求解
    z1=BranchBound1(tempvlb,vub);
    iter=iter+1;
end
if vlb(notintx(1,1),1)<=intx(notintx(1,1),1)
    tempvub(notintx(1,1),1)=intx(notintx(1,1),1);%分支 取更小值出现的范围
    %%%%TODO Put the Code for Problem  at below %%%%
    %递归调用BranchBound1分支求解
    z1=BranchBound1(vlb,tempvub);
    iter=iter+1;
    
end









问题一：在使用分支定界法求解整数规划问题时，如何选择合适的分支策略和剪枝策略，以提高算法的效率和准确性？

解决方法：分支策略是指如何将原问题分解为子问题，剪枝策略是指如何排除不可能更优的子问题。一般来说，分支策略和剪枝策略的选择取决于问题的特点和目标函数的性质。在本实验中，我们采用了以下的分支策略和剪枝策略：

分支策略：选择第一个非整数变量，分别将其上界和下界向下取整或向上取整，得到两个子问题。2这样可以保证每个子问题的可行域是原问题的可行域的子集，且每个子问题的目标函数值不会超过原问题的目标函数值。
剪枝策略：在求解每个子问题的松弛问题时，如果得到的目标函数值大于或等于当前的最优值，或者得到的解不可行，或者没有找到解，则可以直接舍弃该子问题，不再进行分支。这样可以避免无效的搜索，缩小搜索空间，加快收敛速度。
问题二：在使用匈牙利法求解指派问题时，如何处理成本矩阵中的非数字元素，以保证算法的正确性和稳定性？

解决方法：成本矩阵中的非数字元素，如 NaN（非数值）或 Inf（正无穷），表示某些任务与某些工作者之间的分配是不可能的或不合理的。在本实验中，我们采用了以下的处理方法：

将成本矩阵中的所有非数字元素替换为正无穷 Inf。3这样可以保证在进行矩阵的缩减和调整时，不会影响其他元素的值，也不会被选为最小值或最优分配的候选值。
在构建任务分配矩阵时，忽略成本矩阵中的正无穷元素，只考虑有限的数字元素。这样可以保证得到的任务分配方案是可行的，且不包含不可能的或不合理的分配。


