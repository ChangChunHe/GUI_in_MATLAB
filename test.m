clear
clc
close all
N = 10;
squ_size = 500/N;
hf = figure('resize','off','name','Minesweeper','unit','pixels',...
    'position', [400 100 (N+5)*squ_size (N+3)*squ_size],...
    'numbertitle', 'off','menubar','none','color', [205 197 191]/255);
t = axes('Units','pixels', 'PlotBoxAspectRatio',[1 1 1],...
    'Position',[squ_size,squ_size,N*squ_size,N*squ_size],...
    'XLim',[0 N*squ_size],'YLim',[0 N*squ_size],'xtick',[],'ytick',[],...
    'XColor','k','YColor','k', 'visible','on','Color',[205 197 191]/255);
line(repmat([0;squ_size*N],1,N+1),repmat(0:squ_size:N*squ_size,2,1),'color','k');
line(repmat(0:squ_size:squ_size*N,2,1),repmat([0;squ_size*N],1,N+1),'color','k');

h = gobjects(N,N);
for counter = 1:N^2
    jcols = rem(counter,N);
    jcols(jcols==0) = N;
    irows = ceil(counter/N);
    position = [squ_size+(jcols-1)*squ_size squ_size+(N-irows)*squ_size squ_size squ_size];
    h(counter)=uicontrol( 'FontSize',18,'FontWeight','bold',...
        'Position',position,'Style','pushbutton');
end