clear
clc
close all
global N initial circum h
screen_size = get(0,'screensize');
ss = sum(screen_size(3:4));
N=10;bomnumber=0;
hf = figure('resize','off','name','Minesweeper',...
    'position', [450 120 900 825]*ss/3000,...
    'numbertitle', 'off','menubar','none',...
    'color', [205 197 191]/255);
width = 50;height = 50;xoff = 35;
t = axes('Units','pixels', 'PlotBoxAspectRatio',[1 1 1],...
    'Position',[109,200,N*width,N*height],...
    'XLim',[0 N*width+1],'YLim',[0 N*height+1], ...
    'XColor','k','YColor','k', 'visible','on','xtick',[],'ytick',[],'Color',[205 197 191]/255);
line(repmat([0;50*N],1,N+1),repmat([0:50:N*50],2,1),'color','k');
line(repmat([0:50:50*N],2,1),repmat([0;50*N],1,N+1),'color','k');
initial=zeros(N);
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
a=zeros(N+2,N+2);b=zeros(N+2,N+2);
a(2:end-1,2:end-1)=initial;
circum=[];
for counter=1:N^2
    jcols = rem(counter,N);%�У�����
    jcols(jcols==0) = N;
    irows = ceil(counter/N);%�У�ȡ��
    if initial(irows,jcols)==0
        circum(irows,jcols)=sum(a(irows,jcols:jcols+2))+sum(a(irows+2,jcols:jcols+2))+a(irows+1,jcols)+a(irows+1,jcols+2);
    else
        circum(irows,jcols)=9;
    end
end
h = gobjects(N,N);
for counter=1:N^2
    jcols = rem(counter,N);%�У�����
    jcols(jcols==0) = N;
    irows = ceil(counter/N);%�У�ȡ��
    size_squ = 50;
    position = [size_squ*jcols+59 50*N+200-size_squ*irows size_squ-2 size_squ-2]*ss/3000;% here 50*N+200 has replaced 600
    h(counter)=uicontrol( 'FontSize',18,'FontWeight','bold','Position',position,...
        'Style','pushbutton','Tag',num2str(counter),'callback', @check,...
        'BackgroundColor',[1 1 1]);
end

% add a flag number
h_flagbox=uicontrol( 'FontSize',18,'FontWeight','bold',...
        'Position',[size_squ+59 50*N+200-size_squ+50 size_squ-2 size_squ-2]*ss/3000,...
        'Style','text','Tag',num2str(counter),'string', num2str(bomnumber),...
        'BackgroundColor',get(gcf,'color'));