# Minesweeper

这个仓库主要用来用扫雷的例子来对`MATLAB`的`GUI`设计写一个较为细致的教程. 包括如何新建按钮(`pushbutton`)等等简易的`uicontrol`, 还有如何与键盘鼠标交互等等.

[TOC]

### 0.coding-review
写在最前面, 这个[文件](./coding_review.m), 是用来对代码进行比较修改的, 尽可能使用向量化的编程的语句, 其中会有必要的解释说明.

### 1. 图(figure)的组成
在`matlab`中, 一幅图(figure)是有层次(hierachy)的.

![](./doccenter_graphicsheirarchy.png)

图形对象的分层特性反映了对象之间的相互包含关系, 每个对象在图形显示中起特定作用. 一般来说, 你使用`plot` 或者`line`函数创建一条线, `matlab`会自动先帮你创建一个图(figure), 接着帮你创建一个轴(`axes`), 如果你没有自己新建的话. 现在这副图就有了最基本的层次关系`figure-axes-(plot, line, legend, text...)`

```matlab
plot(rand(4))
f = gcf; % get current figure
f.Children % children object of the current figure
a = gca; % get current axes
a.Children % children object of the current axes
```

接下来会主要介绍的是`figure` 和 `axes`这两个对象.

#### 1. position

先说说这个位置(`position`)这个东西啊. 其实这个东西说麻烦也挺麻烦的, 因为里面有一些比较细致的问题需要知道. 而且想要把整个布局做的美观一些, 还是需要每个小控件之间有一定距离, 搞清楚`position`怎么设置的是很重要的. 其实`position`的四个数字就是边界,  依次分别是left, buttom, width, height. 前两个数字就是左下角的坐标, 接着两个数字就是这个东西的宽和高.

但是很明显现在有这样的问题, 我用什么表示坐标和宽高呢. 这里`MATLAB`提供了`Unit`的属性, 可以让你指定使用不同的方式来设置位置. 下面以`figure`为例来说明, 其他控件的位置设置也都是类似的. 

###### 1. 'pixels' (default)     
 使用分辨率来设置位置, 这个是绝对的位置, 所以如果你希望你的图片需要在**任何**电脑上都是指定位置显示的话就使用这个吧. 例如设置`position`为[120, 200, 100, 100], 那么在任何电脑上该图片的左下角的坐标都是[120,200], 以你的屏幕左下角为坐标原点, 单位就是像素点, 比如说你的屏幕是1280*1024, 那就是说屏幕右上角的坐标是[1280,1024], 这样你也就大致知道了[120, 200]在哪了. 

###### 2. normalized        
但是一般而言我们希望图片可以居中, 那么使用像素点的方式就没有那么方便, 但是此时使用`normalized`就可以设置比例, 比如设置`position`为[0.2 0.3 0.1 0.1], 那么就是认为右上角的坐标为[1,1], 然后按照比例计算这个位置. 例如如果我们希望图片居中, 那么图片的位置可以设置为[0.3 0.4 0.4 0.2].

###### 3. 其他的单位(Unit)

具体可以参见`MATLAB`的[官方文档][1], 上面两种是主要的使用的单位, 就在这里具体说一下, 其他的单位也是类似的, 就不再赘述了.

###### 4. Example
给定N, 画出一个N*N 的正方格子, 每个格子都是一个`uicontrol`. 要求: 任意修改N的数值不会改变图片的布局. 
```matlab
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
```


### 2. uicontrol




### 3. 键盘和鼠标的交互

#### 1. 鼠标左右键的响应
首先建立一个点击的响应, 这个使用`ButtonDownFcn`这个属性来实现.
```matlab
 uicontrol('Style','Pushbutton', 'Units','pixels',...
            'Position',[100,100, 200, 100],...
            'ButtonDownFcn',@click_events);
```
这里`get`到`SelectionType`也就是你点击的方式是左键还是右键, 左键是`normal`, 右键是`alt`.
```matlab
function click_events(src,~)
clickType = get(src, 'SelectionType');
if strcmp(clickType, 'alt')
    disp('click right')
elseif strcmp(clickType,'normal')
    disp('click left')
end
```


#### 2. 键盘的响应


  [1]: https://www.mathworks.com/help/matlab/ref/figure.html#buich1u-1_sep_shared-Units
