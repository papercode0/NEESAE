function [T] = constructT(Y)
%constructT 构造one-hot标签形式
type_num = size(unique(Y),1);%类别数目（Y中几种类型相同的元素）
[m,n] = size(Y);
T = zeros(type_num,m);
for i = 1:type_num
   index = find(Y==i);
   c = size(index,1);
   for j = 1:c
       T(i,index(j)) = 1;
   end
end
 
end

