%%%% Put the Code for Problem 1-(3) at below %%%%
%f��һ����������ʾ����Ŀ�꺯����ϵ����
f = [-1; -2]; 
%����A��ʾ���Բ���ʽԼ����ϵ����A��ÿһ�ж�Ӧһ�����Բ���ʽԼ����
A = [2 1; 1 1; -1 1; -2 1]; 
%b��ʾ���Բ���ʽԼ���Ҳ��ֵ��
b = [10; 6; 2; 1]; 
%lb��ʾÿ���������½硣
lb = [0; 0]; 
% ub��һ�������飬��ʾ����û���Ͻ硣
ub = []; 
% ����linprog������������Թ滮���⡣���������
% x����С��Ŀ�꺯���Ľ�������
% fval���ڽ⴦Ŀ�꺯��������ֵ��
% exitflag����ʾ�˳������ı�־��
% output�������й��Ż����̵�������Ϣ�Ľṹ�塣
[x, fval, exitflag, output] = linprog(f, A, b, [], [], lb, ub);




%%%% Put the Code for Problem 1-(4) at below %%%%
f = [-1; -2; 0; 0; 0; 0]; 
%Aeq������ʽԼ����ϵ����ÿһ�ж�Ӧһ����ʽԼ����
Aeq = [2 1 1 0 0 0; 1 1 0 1 0 0; -1 1 0 0 1 0; -2 1 0 0 0 1]; 
%beq������ʽԼ���Ҳ��ֵ����Ӧ��������Ҳࡣ
beq = [10; 6; 2; 1]; 
lb = [0; 0; 0; 0; 0; 0];
ub = [];
[x, fval, exitflag, output] = linprog(f, [], [], Aeq, beq, lb, ub);


%%%% Put the Code for Problem 1-(5) at below %%%%
f = [-1; -2; 0]; 
%Aeq��ʾ��ʽԼ����ϵ����
Aeq = [2 1 1]; 
%A��ʾ����ʽԼ����ϵ����ÿһ�ж�Ӧһ������ʽԼ����
A = [1 1 0; -1 1 0; -2 1 0]
%beq��ʾ��ʽԼ���Ҳ��ֵ
beq = [10]; 
%b��ʾ����ʽԼ���Ҳ��ֵ
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



%options = optimoptions('linprog','Display','iter'); %����ѡ������ʾ������ĵ������ȡ�
%[x, feval, exitflag, output, lambda]=linprog(f,A,b,Aeq,beq,LB,UB,[],options)
% x = -2*pi:0.1:2*pi;
% y = sin(x);
% plot(x, y);
% title('Sine Function');
% xlabel('x');
% ylabel('sin(x)');















