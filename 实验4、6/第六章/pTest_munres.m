% %（2）例题
% disp('=====================================================');
% % 根据具体指定问题，组建成本矩阵
% %%%%TODO Put the Code for Problem  at below %%%%
% A=[82 83 69 92;77 37 49 92;11 69 5 86;8 9 98 23];
% % 使用匈牙利算法解决指派问题
% [assignment,cost]=munkres(A) 
% [assignedrows,dum]=find(assignment);
% order=assignedrows'
% % 输出结果
% for i = 1:size(assignment, 1)
%     %%%%TODO Put the Code for Problem  at below %%%% assignment
%     fprintf('第%d项作业指派给工人%d\n', i, order(i));
% end


% %（3）例6-7
% disp('=====================================================');
% % 根据具体指定问题，组建成本矩阵
% %%%TODO Put the Code for Problem  at below %%%%
% A=[2 15 13 4;10 4 14 15;9 14 16 13;7 8 11 9];
% % 使用匈牙利算法解决指派问题
% [assignment,cost]=munkres(A) 
% [assignedrows,dum]=find(assignment);
% order=assignedrows'
% % 输出结果
% for i = 1:size(assignment, 1)
%     %%%TODO Put the Code for Problem  at below %%%% assignment
%     fprintf('第%d项作业指派给工人%d\n', i, order(i));
% end


%（3）例6-8
disp('=====================================================');
% 根据具体指定问题，组建成本矩阵
%%%%TODO Put the Code for Problem  at below %%%%
A=[12 7 9 7 9;8 9 6 6 6;7 17 12 14 9;15 14 6 6 10;4 10 7 10 9];
% 使用匈牙利算法解决指派问题
[assignment,cost]=munkres(A) 
[assignedrows,dum]=find(assignment);
order=assignedrows'
% 输出结果
for i = 1:size(assignment, 1)
    %%%%TODO Put the Code for Problem  at below %%%% assignment
    fprintf('第%d项作业指派给工人%d\n', i, order(i));
end