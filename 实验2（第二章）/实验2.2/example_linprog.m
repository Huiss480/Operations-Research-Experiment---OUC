% -*- coding:utf-8 -*-
f=[-150;-175];
A=[7 11; 10 8];
b=[77;80];
Aeq=[0 0; 0 0];
beq=[0;0];
LB=[0;0];
UB=[9;6];

options = optimoptions('linprog','Display','iter'); %����ѡ������ʾ������ĵ�������?[x,fval,exitflag,output,lambda]=linprog(f,A,b,Aeq,beq,LB,UB,[], options)
% exitflag = 1, �T??��־د1 ��ʾ����Ǿֲ���С��??disp(lambda.eqlin)% returns the set of Lagrangian multipliers lambda, at the solution: lambda.eqlin for the linear equalities Aeq
options
disp(lambda.ineqlin)% lambda.ineqlin for the linear inequalities A