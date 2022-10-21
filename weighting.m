%%%原始样本空间和聚类空间决策层融合——加权法%%%%%%
clear;close all;clc
 weight_acc2 = [];
 weight_acc3 = [];
 weight_acc4 = [];
 weight_acc5 = [];
for n = 1:5
    resultfile = ['result/pendigits_result',num2str(n),'.mat'];
    load(resultfile);
    N = round(size(testY,1)/2);
    validLable0 = predictLable0(1:N);
    testLable0 = predictLable0(N+1:end);
    validLable1 = predictLable1(1:N);
    testLable1 = predictLable1(N+1:end);
    validLable2 = predictLable2(1:N);
    testLable2 = predictLable2(N+1:end);
    validLable3 = predictLable3(1:N);
    testLable3 = predictLable3(N+1:end);
    validLable4 = predictLable4(1:N);
    testLable4 = predictLable4(N+1:end);

    bestAcc = 1;
    for a = 0:0.1:1
        b = 1-a;
        validLable = round(a*validLable0 + b*validLable1);
        acc = mean(validLable == testY(1:N))*100;
        if(acc > bestAcc)
            x = a;
            y = b;
            bestAcc = acc;
        end  
    end
%     x = 0.6;y = 0.4;
    testLable = round(x*testLable0 + y*testLable1);
    accuracy = mean(testLable == testY(N+1:end))*100;
    weight_acc2 = [weight_acc2; accuracy];
    
    %%原样本空间 + 一级 + 二级聚类样本空间%%%
    bestAcc = 1;   
    for a=0:0.1:1
        b=1-a;
        for d=0:0.1:b
        e=b-d;
        validLable = round(a*validLable0 + d*validLable1 + e*validLable2);
        acc = mean(validLable == testY(1:N))*100;
        if acc > bestAcc
            x=a;
            y=d;
            z=e;  
            bestAcc = acc;
        end
        end
    end
%      x = 0.5;y = 0.3 ;z = 0.2 
    testLable =  round(x*testLable0 + y*testLable1 + z*testLable2);
    accuracy = mean(testLable == testY(N+1:end))*100;
    weight_acc3 = [weight_acc3; accuracy];
    fprintf('\n原空间+一级+二级聚类 Accuracy: %f\n',accuracy);   

    %原样本空间 + 一级 + 二级 + 三级聚类样本空间%%%
    bestAcc = 1;   
    for a=0:0.1:1
        b=1-a;
        for d=0:0.1:b
            e=b-d;
            for f = 0:0.1:e
                g = e-f;
                validLable = round(a*validLable0 + d*validLable1 + f*validLable2 + g*validLable3);
                acc = mean(validLable == testY(1:N))*100;
                if acc > bestAcc
                    x = a;
                    y = d;
                    z = f;  
                    m = g;
                    bestAcc = acc;
                end
            end
        end
    end
%      x = 0.4; y = 0.3; z = 0.2; m=0.1;
    testLable =  round(x*testLable0 + y*testLable1 + z*testLable2 + m*testLable3);
    accuracy = mean(testLable == testY(N+1:end))*100;
    weight_acc4 = [weight_acc4; accuracy];
  

    %%原样本空间 + 一级 +二级 + 三级 + 四级聚类样本空间%%%
    bestAcc = 1;   
    for a=0:0.1:1
        b=1-a;
        for d=0:0.1:b
            e=b-d;
            for f = 0:0.1:e
                g = e-f;
                for h = 0:0.1:g
                    i = g-h;
                    validLable = round(a*validLable0 + d*validLable1 + f*validLable2 + h*validLable3 + i*validLable4);
                    acc = mean(validLable == testY(1:N))*100;
                    if acc > bestAcc
                        x = a;
                        y = d;
                        z = f;  
                        m = h;
                        l = i;
                        bestAcc = acc;
                    end
                end
            end
        end
    end
%      x = 0.3;y = 0.2;z = 0.2; m =0.2; l = 0.1;
    testLable =  round(x*testLable0 + y*testLable1 + z*testLable2 + m*testLable3 + l*testLable4);
    accuracy = mean(testLable == testY(N+1:end))*100;
    weight_acc5 = [weight_acc5; accuracy];   
end 
fprintf('\n原空间+一级聚类 Accuracy: %f\n',mean(weight_acc2));   
fprintf('\n原空间+一级+二级聚类 Accuracy: %f\n',mean(weight_acc3));   
fprintf('\n原空间+一级+二级+三级聚类 Accuracy: %f\n',mean(weight_acc4));   
fprintf('\n原空间+一级+二级+三级+四级聚类 Accuracy: %f\n',mean(weight_acc5));   
