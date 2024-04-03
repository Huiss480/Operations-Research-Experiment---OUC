% -*- coding:utf-8 -*-
f=[-150;-175];
A=[7 11; 10 8];
b=[77;80];
Aeq=[0 0; 0 0];
beq=[0;0];
LB=[0;0];
UB=[9;6];

options = optimoptions('linprog','Display','iter'); %设置选项以显示求解器的迭代进度?[x,fval,exitflag,output,lambda]=linprog(f,A,b,Aeq,beq,LB,UB,[], options)
% exitflag = 1, 逿??标志丿1 表示结果是局部最小忣??disp(lambda.eqlin)% returns the set of Lagrangian multipliers lambda, at the solution: lambda.eqlin for the linear equalities Aeq
options
disp(lambda.ineqlin)% lambda.ineqlin for the linear inequalities A