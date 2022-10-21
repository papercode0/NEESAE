function out = featureChoose(features, i);
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
    [m, n] = size(features);%行是特征数目，列是样本数目
    out = zeros(i,n);
    variance = std(features,0,2);%按行求标准偏差
    [sorted_variance,index] = sort(variance,'descend');%index排序后备元素在原矩阵中的行位置或列位置的索引
    
%     a = randperm(m);
%     for j=1:i
%        out(j,:) = features(a(j),:); 
%     end
    for j = 1:i
        out(j,:) = features(index(j),:);
    end
end

