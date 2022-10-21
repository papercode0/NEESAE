function [new_data,new_label]=KN_datacreat(data,label,k)
%data数据 行样本 列特征
%label数据标签 nx1
%class数据类别个数
%k近邻个数 实际上是算上自己 近邻k-1

%w属性的重要程度
[m,n]=size(data);
Di_index=find(label==1);%找到类别索引
Dni_index=find(label==2);
D3_index=find(label==3);%找到类别索引
D4_index=find(label==4);
D5_index=find(label==5);%找到类别索引
D6_index=find(label==6);
D7_index=find(label==7);%找到类别索引
D8_index=find(label==8);
D9_index=find(label==9);%找到类别索引
D10_index=find(label==10);

Di=data(Di_index,:);%按类别分出数据集
Dni=data(Dni_index,:);
D3=data(D3_index,:);
D4=data(D4_index,:);
D5=data(D5_index,:);
D6=data(D6_index,:);
D7=data(D7_index,:);
D8=data(D8_index,:);
D9=data(D9_index,:);
D10=data(D10_index,:);

new_data=[];
new_label=[];
for i=1:m
dest=data(i,:);%选择一个样本
if label(i,1)==1
    nr=pdist2(dest,Di);%计算该样本和同类样本的欧式距离 1xn hxn  结果 1xh
    [num,idx]=sort(nr);%排序
    new_data=[new_data;Di(idx(2:k),:)];
    new_label=[new_label;ones(k-1,1)]
end
    if label(i,1)==2
    nr=pdist2(dest,Dni);
    [num,idx]=sort(nr);%排序
    new_data=[new_data;Dni(idx(2:k),:)];
    new_label=[new_label;ones(k-1,1)*2];
    end
 if label(i,1)==3
    nr=pdist2(dest,D3);
    [num,idx]=sort(nr);%排序
    new_data=[new_data;D3(idx(2:k),:)];
    new_label=[new_label;ones(k-1,1)*3];
 end
  if label(i,1)==4
    nr=pdist2(dest,D4);
    [num,idx]=sort(nr);%排序
    new_data=[new_data;D4(idx(2:k),:)];
    new_label=[new_label;ones(k-1,1)*4];
  end
   if label(i,1)==5
    nr=pdist2(dest,D4);
    [num,idx]=sort(nr);%排序
    new_data=[new_data;D4(idx(2:k),:)];
    new_label=[new_label;ones(k-1,1)*5];
   end
   if label(i,1)==6
    nr=pdist2(dest,D4);
    [num,idx]=sort(nr);%排序
    new_data=[new_data;D4(idx(2:k),:)];
    new_label=[new_label;ones(k-1,1)*6];
   end
   if label(i,1)==7
    nr=pdist2(dest,D4);
    [num,idx]=sort(nr);%排序
    new_data=[new_data;D4(idx(2:k),:)];
    new_label=[new_label;ones(k-1,1)*7];
  end
   if label(i,1)==8
    nr=pdist2(dest,D4);
    [num,idx]=sort(nr);%排序
    new_data=[new_data;D4(idx(2:k),:)];
    new_label=[new_label;ones(k-1,1)*8];
   end
   if label(i,1)==9
    nr=pdist2(dest,D4);
    [num,idx]=sort(nr);%排序
    new_data=[new_data;D4(idx(2:k),:)];
    new_label=[new_label;ones(k-1,1)*9];
   end
    if label(i,1)==10
    nr=pdist2(dest,D4);
    [num,idx]=sort(nr);%排序
    new_data=[new_data;D4(idx(2:k),:)];
    new_label=[new_label;ones(k-1,1)*10];
 end
end
end