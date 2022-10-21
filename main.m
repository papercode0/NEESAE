clc;close all;clear;
rng('default')
ACC0_ALL = []; %OS
ACC1_ALL = []; %PS
ACC2_ALL = []; %SS
vote_all = []; 
weight_all = [];
tic;
for n = 1:5
    filename1 = ['L0/Statlog/Statlog',num2str(n),'.mat'];
    filename2 = ['L0/Statlog/Statlog',num2str(n),'_newDF.mat'];
    load(filename1);
    load(filename2);
%     type_num=9;
    %OS
    [acc0,predictLable0,scores0] = predict(sample_pair_trainX,trainX_deep_cluster0,trainY,sample_pair_testX,testX_deep_cluster0,testY,type_num);

    %PS
    [acc1,predictLable1,scores1] = predict(sample_pair_trainX1,trainX_deep_cluster1,trainY1,sample_pair_testX1,testX_deep_cluster1,testY,type_num);

    %SS
    [acc2,predictLable2,scores2] = predict(sample_pair_trainX2,trainX_deep_cluster2,trainY2,sample_pair_testX2,testX_deep_cluster2,testY,type_num);

 %
    m = size(testY,1);
    K = zeros(m,1);
    for i = 1:m
        sumw = [];
        for j = 1:type_num
            vote = 0; 
            if predictLable0(i)==j
                vote = vote + 1;
            end 
            if predictLable1(i)==j
                vote = vote + 1;
            end 
            if predictLable2(i)==j
                vote = vote + 1;
            end    
            sumw = [sumw vote];
        end
        [value,ind] =max(sumw);
        K(i) = ind;      
    end   
    vote_acc =  mean(double(K == testY)) * 100; 
  
  %
    acc_best = 1;
    N = round(size(testX,1)/2);
    validscores0 = scores0(1:N,:);
    testscores0 = scores0(N+1:end,:);
    validscores1 =scores1(1:N,:);
    testscores1 = scores1(N+1:end,:);
    validscores2 = scores2(1:N,:);
    testscores2 = scores2(N+1:end,:);
  %%
    validLable0 = predictLable0(1:N);
    testLable0 = predictLable0(N+1:end);
    validLable1 = predictLable1(1:N);
    testLable1 = predictLable1(N+1:end);
    validLable2 = predictLable2(1:N);
    testLable2 = predictLable2(N+1:end);
  %%
    for a=0:0.1:1
        b=1-a;
        for d=0:0.1:b
        e=b-d;
        validLable = round(a*validLable0 + d*validLable1 + e*validLable2);
        acc = mean(validLable == testY(1:N))*100;
        if acc > acc_best
            x=a;
            y=d;
            z=e;  
            acc_best = acc;
        end
        end
    end
    validLable = round(x*validLable0 + y*validLable1 + z*validLable2);%验证集
    testLable =  round(x*testLable0 + y*testLable1 + z*testLable2);
    weight_acc = mean(testLable == testY(N+1:end))*100;
  predic=[validLable;testLable]%整个预测标签
  ground_truth=testY;
  validscores = x*validscores0 + y*validscores1 + z*validscores2;%验证集
    testscores =x*testscores0 + y*testscores1 + z*testscores2;
    Scores=[validscores;testscores];%第二列

    ACC0_ALL = [ACC0_ALL;acc0];
    ACC1_ALL = [ACC1_ALL;acc1];
    ACC2_ALL = [ACC2_ALL;acc2];
    vote_all = [vote_all;vote_acc];
    weight_all = [weight_all; weight_acc];
%%
end
fprintf('\n原始样本空间 Accuracy: %f\n', mean(ACC0_ALL));
fprintf('\n原始 方差: %f\n', std(ACC0_ALL));
fprintf('\n一级样本空间 Accuracy: %f\n', mean(ACC1_ALL));
fprintf('\n一级 方差: %f\n', std(ACC1_ALL));
fprintf('\n二级样本空间 Accuracy: %f\n', mean(ACC2_ALL));
fprintf('\n二级 方差: %f\n', std(ACC2_ALL));
fprintf('\nvote Accuracy: %f\n', mean(vote_all));
fprintf('\nvote 方差: %f\n', std(vote_all));
fprintf('\nweight Accuracy: %f\n', mean(weight_all));
fprintf('\nweight 方差: %f\n', std(weight_all));
toc; 