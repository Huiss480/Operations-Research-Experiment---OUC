function augmentedMatrix = rowReduction(A)
    [m, n] = size(A);
    
    % 构造增广矩阵 [A', I]
    augmentedMatrix = [A', eye(m)];

    for i = 1:min(m, n)
        % 寻找当前列主元所在的行
        [~, maxRow] = max(abs(augmentedMatrix(i:end, i)));
        maxRow = maxRow + i - 1;

        % 交换当前行与主元所在行
        augmentedMatrix([i, maxRow], :) = augmentedMatrix([maxRow, i], :);

        % 主元归一化
        pivot = augmentedMatrix(i, i);
        augmentedMatrix(i, :) = augmentedMatrix(i, :) / pivot;

        % 消元操作，将其他行的对应列元素变为零
        for j = 1:m
            if j ~= i
                multiplier = augmentedMatrix(j, i);
                augmentedMatrix(j, :) = augmentedMatrix(j, :) - multiplier * augmentedMatrix(i, :);
            end
        end
    end
end
