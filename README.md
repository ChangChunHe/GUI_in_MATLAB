# Minesweeper

这个仓库主要用来用扫雷的例子来对`MATLAB`的`GUI`设计写一个较为细致的教程. 包括如何新建按钮(`pushbutton`)等等简易的`uicontrol`, 还有如何与键盘鼠标交互等等.

### 0.coding-review

[TOC]

写在组最前面, 这个[文件](./coding_review.m), 是用来对代码进行比较修改的, 尽可能使用向量化的编程的语句, 其中会有必要的解释说明.

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



### 2. uicontrol




### 3. 键盘和鼠标的交互

#### 1. 左右键的响应
首先建立一个点击的响应, 这个使用`ButtonDownFcn`这个属性来实现, 实际上对于一个`uicontrol`而言, 它是没有右键的响应的, 所以这是用来补充`uicontrol`的功能的.
```matlab
h = figure;
set(h,'ButtonDownFcn',@click_events)
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
