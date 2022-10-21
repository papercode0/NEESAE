function [acc,predictLable,MD] = predict(trainX,trainX_deep,trainY,testX,testX_deep,testY,type_num)
 [m1,n] = size(trainX);
    m2 = size(testX,1);
    acc=[];    
%%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%降维%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PCA%%%%%%%%%%%%%%%%%%%%%%%%   
   [m1,n] = size(trainX_deep);
     method = [];
    method.mode = 'pca';
    acc = 1;
    k_best = n;
    for k = 1:1:n-1
        method.K = k;
        [trainZ,U] = featureExtract(trainX_deep,trainY,method,type_num);
        testZ = projectData(testX_deep, U, method.K);%将测试集按照训练集的映射方式映射到空间中
% %%%%%%%%%%%%%%%%%%%%%%%%%%% SVM %%%%%%%%%%%%%%%%%%%%%%%%%%%
        model = svmtrain(trainY,trainZ,'-s 0 -c 10^5 -t 0 -q -b 1');
%         svm_pred = svmpredict(testY,testZ,model);
 %%%%%%%%%%%%%%%%
 [svm_pred, ~, prob_estimates] = svmpredict(testY,testZ, model,'-b 1');

 %%%%%%%%%%%%%
        svm_pca = mean(double(svm_pred == testY)) * 100;  
        if svm_pca > acc
            acc = svm_pca;
            predictLable = svm_pred;
            MD = prob_estimates;
        end
    end

end