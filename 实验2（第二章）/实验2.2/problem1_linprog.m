%%%% Put the Code for Problem 1-(3) at below %%%%
%f是一个向量，表示线性目标函数的系数。
f = [-1; -2]; 
%矩阵A表示线性不等式约束的系数，A的每一行对应一个线性不等式约束。
A = [2 1; 1 1; -1 1; -2 1]; 
%b表示线性不等式约束右侧的值。
b = [10; 6; 2; 1]; 
%lb表示每个变量的下界。
lb = [0; 0]; 
% ub是一个空数组，表示变量没有上界。
ub = []; 
% 调用linprog函数来解决线性规划问题。输出包括：
% x：最小化目标函数的解向量；
% fval：在解处目标函数的最优值；
% exitflag：表示退出条件的标志；
% output：包含有关优化过程的其他信息的结构体。
[x, fval, exitflag, output] = linprog(f, A, b, [], [], lb, ub);




%%%% Put the Code for Problem 1-(4) at below %%%%
f = [-1; -2; 0; 0; 0; 0]; 
%Aeq包含等式约束的系数，每一行对应一个等式约束。
Aeq = [2 1 1 0 0 0; 1 1 0 1 0 0; -1 1 0 0 1 0; -2 1 0 0 0 1]; 
%beq包含等式约束右侧的值，对应方程组的右侧。
beq = [10; 6; 2; 1]; 
lb = [0; 0; 0; 0; 0; 0];
ub = [];
[x, fval, exitflag, output] = linprog(f, [], [], Aeq, beq, lb, ub);


%%%% Put the Code for Problem 1-(5) at below %%%%
f = [-1; -2; 0]; 
%Aeq表示等式约束的系数。
Aeq = [2 1 1]; 
%A表示不等式约束的系数，每一行对应一个不等式约束。
A = [1 1 0; -1 1 0; -2 1 0]
%beq表示等式约束右侧的值
beq = [10]; 
%b表示不等式约束右侧的值
b = [6; 2; 1]
lb = [0; 0; 0];
ub = [];
[x, fval, exitflag] = linprog(f, A, b, Aeq, beq, lb, ub);


%%%% Put the Code for Problem 1-(7) at below %%%%
f = [-1; -3];  
A = [5, 10; -1 -1; 0 1]; 
b = [50; -1; 4]; 
lb = [0; 0];
ub = [];
[x, fval, exitflag] = linprog(f, A, b, [], [], lb, ub)



%options = optimoptions('linprog','Display','iter'); %设置选项以显示求解器的迭代进度。
%[x, feval, exitflag, output, lambda]=linprog(f,A,b,Aeq,beq,LB,UB,[],options)
% x = -2*pi:0.1:2*pi;
% y = sin(x);
% plot(x, y);
% title('Sine Function');
% xlabel('x');
% ylabel('sin(x)');















