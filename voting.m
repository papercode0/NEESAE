%%%原始样本空间和聚类空间集成——投票法%%%%%%
clc;close;clear;
vote_acc2 = [] ; 
vote_acc3 = [] ; 
vote_acc4 = [] ;  
vote_acc5 = [] ; 
for n = 1:5
    resultfile = ['result/pendigits_result',num2str(n),'.mat'];  
    load(resultfile);
    m = size(testY,1);%测试样本数
    K2 = zeros(m,1); K3 = zeros(m,1); K4 = zeros(m,1); K5 = zeros(m,1);
    for i = 1:m
        sumw2 = [];sumw3 = [];sumw4 = [];sumw5 = [];
        for j = 1:type_num
            vote2 = 0; %原样本空间 + 一级聚类空间
            vote3 = 0; %原样本空间 + 一级聚类空间 + 二级
            vote4 = 0; %原样本空间 + 一级聚类空间 + 二级 + 三级
            vote5 = 0; %原样本空间 + 一级聚类空间 + 二级 + 三级 + 四级
            if predictLable0(i)==j
                vote2 = vote2 + 1;
                vote3 = vote3 + 1;
                vote4 = vote4 + 1;
                vote5 = vote5 + 1;
            end 
            
            if predictLable1(i)==j
                vote2 = vote2 + 1;
                vote3 = vote3 + 1;
                vote4 = vote4 + 1;
                vote5 = vote5 + 1;
            end 
            
            if predictLable2(i)==j
                vote3 = vote3 + 1;
                vote4 = vote4 + 1;
                vote5 = vote5 + 1;
            end    
            if predictLable3(i)==j
                vote4 = vote4 + 1;
                vote5 = vote5 + 1;
            end   
            if predictLable4(i)==j
                vote5 = vote5 + 1;
            end   
            sumw2 = [sumw2 vote2];
            sumw3 = [sumw3 vote3];
            sumw4 = [sumw4 vote4];
            sumw5 = [sumw5 vote5];
        end
        [value2,ind2] =max(sumw2);
        K2(i) = ind2; 
        [value3,ind3] =max(sumw3);
        K3(i) = ind3;     
        [value4,ind4] =max(sumw4);
        K4(i) = ind4;     
        [value5,ind5] =max(sumw5);
        K5(i) = ind5;     
    end   
    vote_acc2 = [vote_acc2; mean(double(K2 == testY)) * 100] ; 
    vote_acc3 =[vote_acc3; mean(double(K3 == testY)) * 100 ] ; 
    vote_acc4 = [vote_acc4; mean(double(K4 == testY)) * 100] ; 
    vote_acc5 = [vote_acc5; mean(double(K5 == testY)) * 100 ];  
end
fprintf('\n原样本 + 一级聚类空间集成结果: %f\n', mean(vote_acc2 ));
fprintf('\n原样本 + 一级 + 二级聚类空间集成结果: %f\n', mean(vote_acc3));
fprintf('\n原样本 + 一级 + 二级+三级聚类空间集成结果: %f\n', mean(vote_acc4));
fprintf('\n原样本 + 一级 + 二级+三级+四级聚类空间集成结果: %f\n', mean(vote_acc5));
