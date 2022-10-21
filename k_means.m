function [cluster_X,cluster_Y] = k_means(trainX,trainY,type_num,p)
%sampleCluster 样本聚类函数（类内聚类）  2/3, 1/2, 1/3, 1/4
cluster_X = [];
cluster_Y = [];
for i = 1:type_num
    % 挑选第i类样本
    idx = find(trainY==i);
    [m,n] = size(idx);
    temp = [];
    for j = 1:m 
        temp = [temp;trainX(idx(j),:)]; 
    end
    % 将第i类样本聚类为原来的一半
    [idx,temp] = kmeans(temp,floor(m*p));
    label = ones(floor(m*p),1);
    label(:) = i;
    %添加标签
    cluster_Y = [cluster_Y;label];
    %得到新的训练集
    cluster_X = [cluster_X;temp];
end

end


