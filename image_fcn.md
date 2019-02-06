给定N, 画出一个N*N 的正方格子, 每个格子都是一个`image`. 要求: 任意修改N的数值不会改变图片的布局, 这个主要是为了实现画出炸弹和小旗子.

首先我们先介绍`image`函数的用法, 首先这个函数是将一个rgb的八位图画成图片的函数, 但是需要指定位置, 就像`text`函数一样, 我们可以指定确定的坐标来放置一个字符, 也就是这样的用法
```matlab
text(x,y,str)
```
这里的`x, y` 就是笛卡尔坐标, 同样的对于一个`image`也有相应的坐标. 但是轴(`axes`)的单位需要是`pixels`, 像素的单位才比较容易操作. 
```matlab
I = imread('./figure/boom.jpg');% boom.jpg源文件就在上面的仓库的`figure`文件夹里面
hax = axes('unit','pixels','xlim',[0 500],'ylim',[0 500]);
hold on % 注意这句一定要写的, 不然image函数会自动帮你重新设置轴的属性的
h1 = image(I);% 此时在不指定图片位置的时候, 默认是从原点开始的
h2 = image([310 400],[400 310],I);
```
下面主要讲讲`h2`这个用法, 第一个参数是图片的左右的坐标, 从左到右的范围, 这里是从310到400, 第二个参数是图片的上下范围, **从上到下**, 不要搞错了..., 第三个参数就是传入图片的rgb数据`I`就可以了. 这里注意到一点, `image`函数会根据你设置的图片范围自动缩放图片的, 比如这里的`I`的大小是276* 276的, 但是h2设置的图片大小只有90* 90其实也是没有关系的, 它可以自动缩放. 

知道了这些就可以来实现画出一个炸弹方阵了.
```matlab
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
I = imread('./figure/boom.jpg');
hold on
for counter = 1:N^2
    jcols = rem(counter,N);
    jcols(jcols==0) = N;
    irows = ceil(counter/N);
    posx = [squ_size*(jcols-1) squ_size*jcols];
    posy = [squ_size*(N-irows+1) squ_size*(N-irows)];
    h(counter)=image(posx,posy,I);
end
```
