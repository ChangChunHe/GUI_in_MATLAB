clear
clc
close all
global N initial circum h
N=15;squ_size = 500/N;
bomnumber=0;
hf = figure('resize','off','name','Minesweeper',...
    'position', [350 60 700 705],...
    'numbertitle', 'off','menubar','none',...
    'color', [205 197 191]/255);
t = axes('Units','pixels', 'PlotBoxAspectRatio',[1 1 1],...
    'Position',[50,100,N*squ_size,N*squ_size],...
    'XLim',[0 N*squ_size],'YLim',[0 N*squ_size],'xtick',[],'ytick',[], ...
    'XColor','k','YColor','k', 'visible','on','Color',[205 197 191]/255);
line(repmat([0;squ_size*N],1,N+1),repmat(0:squ_size:N*squ_size,2,1),'color','k');
line(repmat(0:squ_size:squ_size*N,2,1),repmat([0;squ_size*N],1,N+1),'color','k');
initial=zeros(N);
for i=1:N
    for j=1:N
        initial(i,j) = sign(rand-0.7);
        if initial(i,j) == -1
            initial(i,j) = 0;
        else
            bomnumber = bomnumber + 1;
        end
    end
end
a=zeros(N+2,N+2);b=zeros(N+2,N+2);
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
h = gobjects(N,N);
for counter=1:N^2
    jcols = rem(counter,N);
    jcols(jcols==0) = N;
    irows = ceil(counter/N);
    position = [50-squ_size+squ_size*jcols squ_size*N+100-squ_size*irows squ_size squ_size];
    h(counter)=uicontrol( 'FontSize',18,'FontWeight','bold','Position',position,...
        'Style','pushbutton','Tag',num2str(counter),'callback', @check,...
        'BackgroundColor',[1 1 1]);
end

% add a flag number
h_flagbox=uicontrol( 'FontSize',18,'FontWeight','bold',...
        'Position',[squ_size squ_size*N+110 50 50],...
        'Style','text','Tag',num2str(counter),'string', num2str(bomnumber),...
        'BackgroundColor',get(gcf,'color'));