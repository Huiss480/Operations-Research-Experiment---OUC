% 求解的线性规划问题：
% maximize f = 5x1 + 4x2
% subject to:
% 3x1 + x2 <= 9
% x1 +2x2 <= 8
% x1, x2 >= 0

%一、在Matlab中解决LP问题需要使用优化工具箱。可以使用“linprog”函数来求解LP问题
%LP问题是最小化目标函数 -5x1 - 4x2，满足约束条件 3x1 + x2 >= 9 和 x1 + 2x2 >= 8，并且自变量 x1 和 x2 都不能小于0。
%函数的输出结果包括最优解向量 x，最优目标函数值 fval 和退出标志 exitflag，这些结果都可以用于检验解的正确性。
c = [-2; -3]; % 目标函数系数
A = [1, 2; 4, 0; 0, 4]; % 约束系数矩阵
b = [8; 16; 12]; % 约束常数
lb = [0; 0]; % 自变量下限
ub = []; % 自变量上限
[x, fval, exitflag] = linprog(c, A, b, [], [], lb, ub)

%检验最优解是否正确。可以通过检查LP问题中的KKT条件来判断解是否最优。如果KKT条件满足，那么我们的解就是最优解。
%可以使用“linprog”函数的“output”结构来访问KKT条件。
%如果“output.constrviolation”是“none”，那么解就是最优解。如果不是，“output.constrviolation”将给出约束条件中最违反的约束条件。
options = optimoptions('linprog','Display','off'); % 关闭输出
[x, fval, exitflag, output, lambda] = linprog(c, A, b, [], [], lb, ub, [], options)
% 访问KKT条件
%if strcmp(output.constrviolation, 'none')
%    disp('The solution satisfies the KKT conditions.')
%else
%    disp('The solution does not satisfy the KKT conditions.')
%end

%而使用图解法来求解LP问题，
%我们可以首先绘制每个约束条件对应的直线，然后确定它们的交点。交点表示了约束条件的联合约束解集合，
%这个解集合中的点就是可行解，然后我们需要在这个可行解的解集合中选择一个点，这个点对应的目标函数值最小（或者最大）
%在这个例子中，我们通过脚本逐层绘制了LP问题的约束条件、可行域和目标函数等高线图，并在图中标记了最优解点。

% 绘制约束条件的直线
x1 = linspace(0, 5, 100); % 在[0, 5]区间内生成100个点
x2_1 = (8 - x1)/2; % 约束条件1对应的直线
x1_2 = 4; % 约束条件2对应的直线
x2_3 = 3; % 约束条件3对应的直线

%要使用不同的直线，请通过更改参数a、b、c的值来修改代码。注意，
%直线方程的一般形式为ax+by+c=0，所以我们在计算交点时要将其转化为一个线性方程组。
% 定义第一条直线的参数
a1 = 1;
b1 = 2;
c1 = 8;
% 定义第二条直线的参数
a2 = 1;
b2 = 0;
c2 = 4;
%定义第三条直线的参数
a3=0;
b3=1;
c3=3;

% 计算三条直线的交点坐标
A = [a1 ,b1; a2 ,b2;a3,b3];
b = [c1; c2;c3];
pt = A\b;
disp(['三条直线的交点坐标：x1=',num2str(pt(1))," ",'x2=',num2str(pt(2))]);

plot(x1, x2_1, 'g', 'LineWidth', 2) % 绘制第一条约束直线
hold on
plot(x1_2*ones(size(x1)), x1, 'b', 'LineWidth', 2) % 绘制第二条约束直线
hold on
plot(x1, x2_3, 'r', 'LineWidth', 2) % 绘制第二条约束直线
hold on
plot(pt(1), pt(2), 'ko', 'MarkerSize', 4, 'LineWidth', 2') % 标记交点


% 绘制可行域，即约束直线的交点
[X1, X2] = meshgrid(0:0.1:5); % 生成网格点
Z = 0.*X1; % 定义一个与X1和X2等维度的矩阵
for i = 1:length(X1(:))
    x = [X1(i); X2(i)];
    if A*x <= b % 如果该点在可行域内，则在对应的矩阵中标记为1
        Z(i) = 1; 
    end
end
contour(X1, X2, Z, 1, 'k', 'LineWidth', 2) % 绘制可行域

% 绘制目标函数等高线图，并标记最优解点
x1 = linspace(0, 5, 100); % 在[0, 5]区间内生成100个点
x2 = linspace(0, 5, 100); % 在[0, 5]区间内生成100个点
[X1, X2] = meshgrid(x1, x2); % 生成网格点
Z = -2*X1 - 3*X2; % 目标函数的等值线
contour(X1, X2, Z, -32:-1, 'r', 'LineWidth', 2) % 绘制等高线
[x_opt, y_opt] = fmincon(@(x) -2*x(1) - 3*x(2), [0, 0], A, b); % 求解最优解点
plot(x_opt(1), x_opt(2), 'ko', 'MarkerSize', 10, 'LineWidth', 2) % 标记最优解点
disp(['最优解为 x1 = ' num2str(x_opt(1)) ', x2 = ' num2str(x_opt(2))]);
x_opt(1) 
x_opt(2)
