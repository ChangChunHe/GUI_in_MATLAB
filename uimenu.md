# uimenu

`uimenu`就是`figure`最上方的一排`menu`, 如下图所示
![][1]
相比于`popupmenu`作为菜单可以更加标准一些.  下面就介绍一下`uicontrol`的一些用法.

[uimenu](#uimenu)</br>
&emsp;[1. Label and Text](#1-label-and-text)</br>

## 1. Label and Text
首先介绍的是菜单的名称设置, 是通过`label`或者`text`, 新的版本会移除`label`这个属性改用`text`. 

```matlab
clear;clc;close all
hf = figure('menubar','none','toolbar','none');%这里是关闭默认的工具栏和菜单
h_menu=uimenu(gcf,'label','难度设置');%这里就可以新建一个难度设置的菜单
%接着设置下拉出来的选项
h_submenu = cell(1,4);
h_submenu{1}=uimenu(h_menu,'label','简单','callback',@simple_level);
h_submenu{2}=uimenu(h_menu,'label','中等','callback',@middle_level);
h_submenu{3}=uimenu(h_menu,'label','困难','callback',@hard_level);
h_submenu{4}=uimenu(h_menu,'label','自定义难度','callback',@customize_level);
```
注意到这里可以设置多个`uimenu`, 其显示的位置是从左到右, 按照你代码的顺序向右依次排列, 同样地, 下拉的顺序与你设置`submenu`的先后顺序也保持一致, 

## 2. check
`check`这个属性, 设置为`on`的时候就可以显示出选中的效果, 如下图所示
![此处输入图片的描述][2]

这里我们可以使用`check`属性实现选择难度后在前面显示对号. 实现的代码如下, 需要注意的是设置其中一个`submenu`的`check`为`on`时, 需要同时设置其余的`check`为`off`.
```matlab
clear;clc;close all
global h_submenu
hf = figure('menubar','none','toolbar','none');%这里是关闭默认的工具栏和菜单
h_menu=uimenu(gcf,'label','难度设置');%这里就可以新建一个难度设置的菜单
%接着设置下拉出来的选项
h_submenu = cell(1,4);
h_submenu{1}=uimenu(h_menu,'label','简单','callback',@simple_level);
h_submenu{2}=uimenu(h_menu,'label','中等','callback',@middle_level);
h_submenu{3}=uimenu(h_menu,'label','困难','callback',@hard_level);
h_submenu{4}=uimenu(h_menu,'label','自定义难度','callback',@customize_level);
function simple_level(src,~)
global h_submenu
for ii = [2 3 4];set(h_submenu{ii},'check','off');end
set(src,'check','on')
end
function middle_level(src,~)
global h_submenu
for ii = [1 3 4];set(h_submenu{ii},'check','off');end
set(src,'check','on')
end
function hard_level(src,~)
global h_submenu
for ii = [2 1 4];set(h_submenu{ii},'check','off');end
set(src,'check','on')
end
function customize_level(src,~)
global h_submenu
for ii = [2 3 1];set(h_submenu{ii},'check','off');end
set(src,'check','on')
end
```

  [1]: https://raw.githubusercontent.com/ChangChunHe/Minesweeper/master/figure/figure-uimenu.png
  [2]: https://raw.githubusercontent.com/ChangChunHe/Minesweeper/master/figure/uimenu_check.png
