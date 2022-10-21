clear all
close all  
addpath libsvm-new
rng('default');
load ("L0/AD/AD2.mat"); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%聚类%%%%%%%%%%%%%%%%%%%%%%%%%
trainX = sample_pair_trainX;
testX = sample_pair_testX;

 [trainX, mu, sigma] = featureCentralize(trainX);%%将样本标准化（服从N(0,1)分布）
    testX = bsxfun(@minus, testX, mu);
    testX = bsxfun(@rdivide, testX, sigma);%%将测试样本标准化

dataX=trainX;
dataY=trainY;
p=1/2; % p=[2/3,1/2,1/3,1/4] 修改不同的聚类比例
[dataX1,dataY1] = k_means(dataX,dataY,type_num,p); % 
trainX_1 = dataX1;
trainY_1 =dataY1;

Xt_train = trainX'; %%聚类前的数据集和标签
% Xs_test = testX2';
target_label_train = trainY';
% target_label_test = testY1';
Xs_train = trainX_1'; %%聚类后的数据集和标签 
Xt_test = testX';
source_label_train = trainY_1';
source_label_test = testY';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Graph_Xt_train_num=2;
Graph_Xt_test_num=5;

ker_type=1; % 0:linear 1:nonlinear
        Kernel='linear';
     ALLX=[Xs_train Xt_train];
%      Xs_train=[Xs_train Xt_train];
%      Xt_train=[Xt_train Xt_test];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 svm_lppmmd_best = 1;
m=size(ALLX,2);
i=size(ALLX,1);
n=i;
z_svm_orig=zeros(1,i);
for n=1:i
traindata=ALLX';
trainlabel=[trainY_1;trainY];
X=datasample(traindata,n)';
%%%%%%%%%%%%%%%%%%%%%LPPMMD%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Z,P,Ks, Kt,KY_test]=ICM(X,Xs_train,Xt_train,Xt_test,Graph_Xt_train_num,Graph_Xt_test_num,Kernel);    
%     %------------------------------------------------------   

     KX_train  = Ks;
     KY_train  = Kt;
%      KY_test  = KY_test;
     
   X_train  = P'*KX_train;
   Y_train  = P'*KY_train;
   Xt_test_new  = P'*KY_test;  
   %svm
  Yat=[source_label_train]';%target_label_train 标签
  Xat=[X_train(:,1:length(source_label_train))]';   
   
   model = svmtrain(Yat,Xat,'-s 0 -c 10^5 -t 0 -q');
    svm_pred = svmpredict(testY,Xt_test_new',model); %预测标签
   svm_orig = mean(double(svm_pred == testY)) * 100;
   z_svm_orig(n)=svm_orig;
  
   
   if svm_orig > svm_lppmmd_best
            svm_lppmmd_best = svm_orig;
    trainX1 = Xat;
    trainY1 = Yat;
    testX1=Xt_test_new';
%     testY1=testY;
            n_best = n;
        end
end  
 [best,index]=max(z_svm_orig)
   save("L0/AD/AD1.mat","X1","trainX1", "trainY1","-append");%,"-append"