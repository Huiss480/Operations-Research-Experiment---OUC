%Simplex Method  利用单纯形法的MATLAB程序
function [xstar,fxstar,iter]=pStandSimplex(A,b,c)
%输入f是检验数的数组，1*n维
%输入A是约束矩阵， m*n维
%输入b是约束向量， 1*m维
%输出x是解向量
%输出y是最优解
%判断输入维数是否相符
%做初始单纯形表
% 需要自己编程关键代码处：%%%% Put the Code for Problem  at below %%%%
xstar=0;fxstar=0;iter=0;
format rat %将结果以分数表示

% M 相关矩阵的线性规划问题
[m, n] = size(A);
% 对每个约束进行标准化。
for i = 1:m
    if b(i) < 0
        A(i, :) = -A(i, :);
        b(i) = -b(i);
    end
end
% 在矩阵中添加对角线，使约束条件变为等式
SP = [A eye(m) b; c'  zeros(1, m) 0];
disp('标准化矩阵：');
%disp(SP);

%消除 b c向量方向问题,b是列向量进来,c是行向量
[c1, c2]=size(c);
if c2==1
   f=c';
else
    f=c;
end
[b1, b2]=size(b);
if b1==1
   b=b';
end

%S=[f 0;A b]; 更改后检验数在最后一行
S=[A b;f 0]; 
%[Sm, Sn]=size(S);
%显示初始单纯形表
disp('显示初始单纯形表:')
disp(S)
[n,m]=size(S)
%判断检验数 r<=0
r=find(f>0);
disp('非负检验数所对列:');
disp(r);
len=length(r);
%有大于0的检验数则进入循环
lk=0;
while(len)
    %检查非负检验数所对列向量元素是否都小于等于0
    for k=1:length(r)
        d=find(S(:,r(k))>0);
        %disp('非负检验数所对列向量元素大于零:');
        %disp(d);
        if(length(d)+1==2)
        error('无最优解！！！')  
        %break;
        end
    end
    %找到检验数中最大值 Rk是相应的检验数 最大值所在列j，找到入基变量
    [Rk,j]=max(S(n,1:m-1)); %[Rk,j]=max(S(1,1:m-1));
    
    %%%%TODO Put the Code for Problem  at below %%%%
    %%%%TODO Put the Code for Problem  at below %%%%
    %求单纯性表的最后一列（theta值列），右端常数项b与入基变量所在列j的比值
    rb=。。。
    %rb是单纯性表的最后一列theta值列，找到比值最小的，把比值中的负数都变无穷 
    for p=1:length(rb)
        if(rb(p)<0) 
            rb(p)=Inf;
        end
    end
    %显示theta值列的变化
    disp('显示theta值列的变化');
    disp(rb);
    
    [h,i]=min(rb);%列向量比值最小值 
    % i为旋转元所在行号(在S中)，j为旋转元所在列号 
    disp('i=');i %检验数在最后一行
   
    %进行换基操作,旋转元元素置1，旋转元所在行的的变化
    S(i,:)=S(i,:)./S(i,j);
    
    %%%%TODO Put the Code for Problem  at below %%%%
    %%%%TODO Put the Code for Problem  at below %%%%
    %旋转元所在列其他元素都置0，其他各行的的变化
    for k=1:n
        if(k~=i)
            %%%% Put the Code for Problem  at below %%%%
            S(k,:)=%。。。
        end   
    end
    %判断检验数 r<=0
    r=find(S(n,1:m-1)>0);%r=find(S(1,1:m-1)>0);
    len=length(r);
    lk=lk+1;
    %展示单纯形表的变化
    disp(S);
end
    %检验数全部非正，找到最优解
    %非基变量置0
    x=zeros(1,m-1);
    for i=1:m-1
        %找到基变量
        j=find(S(:,i)==1);%每列中1的个数
        k=find(S(:,i)==0);%每列中0的个数
        if((length(j)+1==2)&&(length(k)+1==n))
            %i为基本元列号，j是行号 基变量值
            x(i)=S(j,m);
        end
    end
     %最后的单纯形表
    y=S(n,m)%最优解y=S(1,m)
    S
    %m
    xstar=x;
    fxstar=-y;
    iter=lk;
end
