clear
clc
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
initial_copy = rand(N);
initial_copy(initial_copy > 0.8) = 1;
initial_copy(initial_copy < 1) = 0;
bomnumber_copy = length(find(initial_copy));
