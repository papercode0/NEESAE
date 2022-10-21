function [X_norm, mu, sigma] = featureCentralize(X)

mu = mean(X);
X_norm = bsxfun(@minus, X, mu);%两个数组元素逐个计算的二值操作，第一个参数是函数句柄。去均值

sigma = std(X);%  standard deviation(标准差)
X_norm = bsxfun(@rdivide, X_norm, sigma);%将样本标准化，使其服从正态分布

end
