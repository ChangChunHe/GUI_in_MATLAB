clear
clc
%% generate 0-1 matrix
% version 1
N = 10;
initial=zeros(N);
bomnumber = 0;
for i=1:N
    for j=1:N
        initial(i,j)=sign(rand-0.8);
        if initial(i,j)==-1
            initial(i,j)=0;
        else
            bomnumber=bomnumber+1;
        end
    end
end

%version 2
% 实际上我们只需要先随机生成一个均匀随机矩阵, 然后使得大于0.8的为1, 其他的为0就可以实现所需的要求了.
initial_copy = rand(N);
initial_copy(initial_copy > 0.8) = 1;
initial_copy(initial_copy < 1) = 0;
bomnumber_copy = length(find(initial_copy));
