function restart(~,~)
global win_game initial circum h N h_flag flag_val h_flagbox
bomnumber = 0;
squ_size = 500/N;
delete(win_game)%delete slogan

initial=zeros(N);
for i=1:N
    for j=1:N
        initial(i,j) = sign(rand-0.85);
        if initial(i,j) == -1
            initial(i,j) = 0;
        else
            bomnumber = bomnumber + 1;
        end
    end
end
a=zeros(N+2,N+2);
a(2:end-1,2:end-1)=initial;
circum=zeros(N);
for counter=1:N^2
    jcols = rem(counter,N);
    jcols(jcols==0) = N;
    irows = ceil(counter/N);
    if initial(irows,jcols)==0
        circum(irows,jcols)=sum(a(irows,jcols:jcols+2))+sum(a(irows+2,jcols:jcols+2))+a(irows+1,jcols)+a(irows+1,jcols+2);
    else
        circum(irows,jcols)=9;
    end
end

for counter=1:N^2
    irows = rem(counter,N);
    irows(irows==0) = N;
    jcols = ceil(counter/N);
    position = [squ_size+(jcols-1)*squ_size+squ_size*0.025 ...
         squ_size+(N-irows)*squ_size+squ_size*0.025 ...
         squ_size*0.95 squ_size*0.95];
     delete(h(counter))
     delete(h_flag(counter))
    h(counter)=uicontrol( 'FontSize',18,'FontWeight','bold','Position',position,...
        'Style','pushbutton','Tag',num2str(counter),'callback', @check,'ButtonDownFcn',@switch_flag);
end

% add a flag number
set(h_flagbox,'string', num2str(bomnumber));
h_flag = gobjects(N); %contain image flag handle
% flag_value record  whether each block has a flag or not
flag_val = zeros(N);