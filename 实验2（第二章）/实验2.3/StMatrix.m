function [A1,b1]=StMatrix(A,b)
% 假设约束矩阵为 A，约束向量为 b 将约束矩阵变成标准形式，使得每个约束都是形如 Ax≤b 的形式，并且同时将矩阵 A 转换成单位阵。
%该代码假设约束矩阵 A 每行都至少有一个非零元素，如果存在全为零的行则需要对其进行处理。
[m, n] = size(A); % 获取 A 的行列数
for i = 1:m
    if any(A(i, :) ~= 0) % 如果第 i 行不全为 0
        % 将第 i 行标准化（即除以第一个非零元素）
        pivot = A(i, find(A(i, :), 1)); % 获取第一个非零元素
        A(i, :) = A(i, :) / pivot;
        b(i) = b(i) / pivot;
        % 对每个非零元素所在列应用高斯消元，使其它位置为零
        for j = 1:m
            if j ~= i && A(j, find(A(i, :), 1)) ~= 0 % 如果第 j 行和第 i 行非零元素在同一列
                factor = A(j, find(A(i, :), 1)); % 获取倍乘因子
                A(j, :) = A(j, :) - factor * A(i, :); % 高斯消元
                b(j) = b(j) - factor * b(i);
            end
        end
    end
end
disp('显示标准化单位阵A：');
A1=A;
b1=b;
disp(A1);