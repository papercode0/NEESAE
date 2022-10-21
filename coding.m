function deep_feature = coding(deepnet,m, X)
%coding 自动编码器的深度特征提取函数
%   deepnet 训练好的堆栈深度网络； m为需要编码的样本数目， X为编码数据（不含标签）
                
    b1 = repmat(deepnet.b{1,1}',m,1);
    encode1 = logsig(X*deepnet.IW{1,1}' + b1); %第一层输出
    

    b2 = repmat(deepnet.b{2,1}',m,1);
    encode2 = logsig(encode1*deepnet.LW{2,1}' + b2); %第二层输出

    b3 = repmat(deepnet.b{3,1}',m,1);
    encode3 = logsig(encode2*deepnet.LW{3,2}' + b3); %第三层输出 
    deep_feature = encode3;
end

