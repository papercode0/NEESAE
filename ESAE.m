%%%%%%%%%%%%%%%%%%%%%%%%  Embedded stacked sparse autoencoder  %%%%%%%%%%%%%%%%%%%
%%https://blog.csdn.net/qq_36108664/article/details/107809983
clear ; close all; clc
rng('default')%设置随机种子,网络初始权值是随机初始化的，避免每次的实验结果不一致
tic;
load ("L0/vehicle/vehicle4.mat"); 
% [trainX1,trainY1] = k_means(trainX,trainY,type_num,0.5); % 在聚类样本空间下训练编码器
% trainX = sample_pair_trainX;
% trainY = sample_pair_trainY;
% testX = sample_pair_testX;
% testY = sample_pair_testY;
% trainX = trainX1;
% trainY = trainY1;
% testX = testX2;
% testY = testY2;
T = constructT(trainY);               %标签处理成one-hot形式，softmax层用到
trainX_map  = mapminmax(trainX',0,1); %样本归一化,编码器的激活函数是sigmoid输出范围是0-1
testX_map = mapminmax(testX',0,1);
record = [];
[m,n]= size(trainX);
[m1,n1]= size(testX);
best_accuracy = 1;

L2WeightRegularization = 0.001; %正则项惩罚系数
SparsityRegularization =5;     %系数项惩罚系数
SparsityProportion = 0.05;      %稀疏参数 （以上三个参数需要调优,在下列自编码器函数中参数的设置时运用）
%%
% for L2WeightRegularization=[0.0001,0.001,0.01]
%     for SparsityRegularization=[1,2,3,4,5,6]
%         for SparsityProportion = [0.02,0.04,0.06,0.08,0.1]
% L2WeightRegularization = 0.0001; %正则项惩罚系数

%%%%i,j,k 网络隐层神经元个数没有既定的设置准则，根据特征数量和样本数量来确定范围寻优%%%
for i = 240													
    for j = 120
        for k = 2:2:18 													
            hiddenSize = i;
            autoenc1 = trainAutoencoder(trainX',hiddenSize,...%编码器输入数据格式: d*N,该函数默认对输入数据归一化处理
                'MaxEpochs',1000,...  %迭代次数
                'L2WeightRegularization',L2WeightRegularization,...%损失函数中L2权重调整器的系数λ=0.0001
                'SparsityRegularization',SparsityRegularization,...%控制稀疏正则器对成本函数的影响的系数β=4
                'SparsityProportion',SparsityProportion,...%它控制隐藏层输出的稀疏性
                'encoderTransferFunction','logsig',...%编码器激活函数
                'DecoderTransferFunction','logsig');  %解码器激活函数
            %Extract the features in the hidden layer.
            features1 = encode(autoenc1,trainX');%使用自编码器对输入数据进行编码
            %嵌入原始特征到第一层隐层编码特征当中
            features1 = [features1;trainX_map];
            features1 = featureChoose(features1, i); 

            hiddenSize = j;
            autoenc2 = trainAutoencoder(features1,hiddenSize,...
                 'MaxEpochs',1000,...
                'L2WeightRegularization',L2WeightRegularization,...
                'SparsityRegularization',SparsityRegularization,...
                'SparsityProportion',SparsityProportion,...
                'encoderTransferFunction','logsig',...
                'DecoderTransferFunction','logsig');
            %Extract the features in the hidden layer.
%使用第一个自编码器的输出作为第二个自编码器的输入。
            features2 = encode(autoenc2,features1);
            features2 = [features2;trainX_map];
            features2 = featureChoose(features2, j); 

            hiddenSize = k;
            autoenc3 = trainAutoencoder(features2,hiddenSize,...
                 'MaxEpochs',1000,...
                'L2WeightRegularization',L2WeightRegularization,...
                'SparsityRegularization',SparsityRegularization,...
                'SparsityProportion',SparsityProportion,...
                'encoderTransferFunction','logsig',...
                'DecoderTransferFunction','logsig');
            %Extract the features in the hidden layer.
            features3 = encode(autoenc3,features2);
           %%%%以上是预训练阶段%%%%%
            
            
            %增加softmax分类层，使用训练数据的标签以有监督方式训练 softmax 层。
            softnet = trainSoftmaxLayer(features3,T,'LossFunction','crossentropy'); 
            %trainSoftmaxLayer(输入特征，输出标签，参数(循环次数)，参数值)

           
            
            deepnet = stack(autoenc1,autoenc2,autoenc3,softnet);%构造堆栈编码器，自编码器中的编码器已用于提取特征。您可以将自编码器中的编码器与 softmax 层堆叠在一起，以形成用于分类的堆叠网络
            
            deepnet = train(deepnet,trainX',T);%网络微调，通过以有监督方式基于训练数据重新训练网络来微调网络
            
            %用训练好的网络对训练集和测试集进行编码
            train_deepFeature = coding(deepnet,m, trainX_map');%训练样本深度特征提取
            test_deepFeature = coding(deepnet,m1, testX_map');%测试样本特征提取

            model = svmtrain(trainY,train_deepFeature,'-s 0 -c 10^5 -t 0 -q'); %训练分类器
            svm_pred = svmpredict(testY,test_deepFeature,model); 
            accuracy = mean(double(svm_pred == testY)) * 100; 
            if(accuracy > best_accuracy)
                trainX_deep_best = train_deepFeature;
                testX_deep_best = test_deepFeature;
                best_accuracy = accuracy;
                network = deepnet;
                BestL2=L2WeightRegularization;
                BestSR=SparsityRegularization;
                BestSP=SparsityProportion;
%                 besti=i
%                 bestj=j
%                 bestk=k
                        end
    end
end
            end
%         end
%     end 
% end
toc;
% %%记录下这六个值
% besti
% bestj
% % bestk
%   BestL2
%    BestSR
%    BestSP

%  view(deepnet)
 view(network)
% network1 = network;
% trainX_deep_cluster1 = trainX_deep_best;%一次聚类样本空间下提取出来的特征
% testX_deep_cluster1 = testX_deep_best;
% network2 = network;
% trainX_deep_cluster2 = trainX_deep_best;%二次聚类样本空间下提取出来的特征
% testX_deep_cluster2 = testX_deep_best;
% save("C1/AD/AD1_newDF","trainX_deep_cluster1","testX_deep_cluster1","network");%保存聚类生成的样本
trainX_deep_cluster0 = trainX_deep_best;
testX_deep_cluster0 = testX_deep_best;
save("L0/vehicle/vehicle4_newDF","trainX_deep_cluster0","testX_deep_cluster0","network","-append"); %保存深度特征
 

 
