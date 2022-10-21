function [new_data]=KN_datacreat(train_data,train_label,test_data,test_label,k)
%data数据 行样本 列特征
%label数据标签 nx1
%class数据类别个数
%k近邻个数 实际上是算上自己 近邻k-1

%w属性的重要程度
[m,n]=size(train_data);
[g,h]=size(test_data);
D1_index=find(train_label==1);%找到类别索引
D2_index=find(train_label==2);
D3_index=find(train_label==3);%找到类别索引
D4_index=find(train_label==4);
D5_index=find(train_label==5);%找到类别索引
D6_index=find(train_label==6);
D7_index=find(train_label==7);%找到类别索引
D8_index=find(train_label==8);
D9_index=find(train_label==9);%找到类别索引
D10_index=find(train_label==10);

D1=train_data(D1_index,:);%按类别分出数据集
D2=train_data(D2_index,:);
D3=train_data(D3_index,:);
D4=train_data(D4_index,:);
D5=train_data(D5_index,:);
D6=train_data(D6_index,:);
D7=train_data(D7_index,:);
D8=train_data(D8_index,:);
D9=train_data(D9_index,:);
D10=train_data(D10_index,:);

new_data=[];
new_label=[];
for j=1:g %测试样本
   
dest=test_data(j,:);%选择一个样本
if test_label(j,1)==1   %判断测试样本类别
%      for i=1:m 
% if train_label(i,1)==1
    nr=pdist2(dest,D1);%计算该样本和训练集中同类样本的欧式距离 1xn hxn  结果 1xh
       [num,idx]=sort(nr);%排序
% end
%      end

    new_data=[new_data;D1(idx(1:k),:)];
%     new_label=[new_label;ones(k-1,1)]
end
if test_label(j,1)==2
%      for i=1:m 
% if train_label(i,1)==2
    nr=pdist2(dest,D2);%计算该样本和训练集中同类样本的欧式距离 1xn hxn  结果 1xh
     [num,idx]=sort(nr);%排序
% end
%      end

    new_data=[new_data;D2(idx(1:k),:)];
%     new_label=[new_label;ones(k-1,1)*2]
end
if test_label(j,1)==3
%      for i=1:m 
% if train_label(i,1)==3
    nr=pdist2(dest,D3);%计算该样本和训练集中同类样本的欧式距离 1xn hxn  结果 1xh
     [num,idx]=sort(nr);%排序
% end
%      end
    new_data=[new_data;D3(idx(1:k),:)];
%     new_label=[new_label;ones(k-1,1)*3]
end

if test_label(j,1)==4   %判断测试样本类别
    nr=pdist2(dest,D4);%计算该样本和训练集中同类样本的欧式距离 1xn hxn  结果 1xh
       [num,idx]=sort(nr);%排序
    new_data=[new_data;D4(idx(1:k),:)];
end

if test_label(j,1)==5   %判断测试样本类别
    nr=pdist2(dest,D5);%计算该样本和训练集中同类样本的欧式距离 1xn hxn  结果 1xh
       [num,idx]=sort(nr);%排序
    new_data=[new_data;D5(idx(1:k),:)];
end

if test_label(j,1)==6   %判断测试样本类别
    nr=pdist2(dest,D6);%计算该样本和训练集中同类样本的欧式距离 1xn hxn  结果 1xh
       [num,idx]=sort(nr);%排序
    new_data=[new_data;D6(idx(1:k),:)];
end

if test_label(j,1)==7   %判断测试样本类别
    nr=pdist2(dest,D7);%计算该样本和训练集中同类样本的欧式距离 1xn hxn  结果 1xh
       [num,idx]=sort(nr);%排序
    new_data=[new_data;D7(idx(1:k),:)];
end
if test_label(j,1)==8   %判断测试样本类别
   nr=pdist2(dest,D8);%计算该样本和训练集中同类样本的欧式距离 1xn hxn  结果 1xh
       [num,idx]=sort(nr);%排序
    new_data=[new_data;D8(idx(1:k),:)];
end
if test_label(j,1)==9   %判断测试样本类别
    nr=pdist2(dest,D9);%计算该样本和训练集中同类样本的欧式距离 1xn hxn  结果 1xh
       [num,idx]=sort(nr);%排序
    new_data=[new_data;D9(idx(1:k),:)];
end

if test_label(j,1)==10   %判断测试样本类别
    nr=pdist2(dest,D10);%计算该样本和训练集中同类样本的欧式距离 1xn hxn  结果 1xh
       [num,idx]=sort(nr);%排序
    new_data=[new_data;D10(idx(1:k),:)];
end
%     if train_label(i,1)==2
%     nr=pdist2(dest,Dni);
%     [num,idx]=sort(nr);%排序
%     new_data=[new_data;Dni(idx(2:k),:)];
%     new_label=[new_label;ones(k-1,1)*2];
%     end
%  if train_label(i,1)==3
%     nr=pdist2(dest,D3);
%     [num,idx]=sort(nr);%排序
%     new_data=[new_data;D3(idx(2:k),:)];
%     new_label=[new_label;ones(k-1,1)*3];
%  end
%   if train_label(i,1)==4
%     nr=pdist2(dest,D4);
%     [num,idx]=sort(nr);%排序
%     new_data=[new_data;D4(idx(2:k),:)];
%     new_label=[new_label;ones(k-1,1)*4];
%   end
%    if train_label(i,1)==5
%     nr=pdist2(dest,D4);
%     [num,idx]=sort(nr);%排序
%     new_data=[new_data;D4(idx(2:k),:)];
%     new_label=[new_label;ones(k-1,1)*5];
%    end
%    if train_label(i,1)==6
%     nr=pdist2(dest,D4);
%     [num,idx]=sort(nr);%排序
%     new_data=[new_data;D4(idx(2:k),:)];
%     new_label=[new_label;ones(k-1,1)*6];
%    end
%    if train_label(i,1)==7
%     nr=pdist2(dest,D4);
%     [num,idx]=sort(nr);%排序
%     new_data=[new_data;D4(idx(2:k),:)];
%     new_label=[new_label;ones(k-1,1)*7];
%   end
%    if train_label(i,1)==8
%     nr=pdist2(dest,D4);
%     [num,idx]=sort(nr);%排序
%     new_data=[new_data;D4(idx(2:k),:)];
%     new_label=[new_label;ones(k-1,1)*8];
%    end
%    if train_label(i,1)==9
%     nr=pdist2(dest,D4);
%     [num,idx]=sort(nr);%排序
%     new_data=[new_data;D4(idx(2:k),:)];
%     new_label=[new_label;ones(k-1,1)*9];
%    end
%     if train_label(i,1)==10
%     nr=pdist2(dest,D4);
%     [num,idx]=sort(nr);%排序
%     new_data=[new_data;D4(idx(2:k),:)];
%     new_label=[new_label;ones(k-1,1)*10];
%  end
% end
%     end
end
end