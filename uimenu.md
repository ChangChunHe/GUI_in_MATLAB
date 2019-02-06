# uimenu

`uimenu`就是`figure`最上方的一排`menu`, 如下图所示![][1], 
相比于`popupmenu`作为菜单可以更加标准一些.  下面就介绍一下`uicontrol`的一些用法.

[uimenu](#uimenu)</br>
&emsp;[1. Label and Text](#1-label-and-text)</br>

## 1. Label and Text
首先介绍的是菜单的名称设置, 是通过`label`或者`text`, 新的版本会移除`label`这个属性改用`text`. 

```matlab
hf = figure('menubar','none','toolbar','none');%这里是关闭默认的工具栏和菜单
h_menu1=uimenu(gcf,'label','难度设置');%这里就可以新建一个难度设置的菜单
h_menu2=uimenu(gcf,'label','我是一个小菜单');
%接着设置下拉出来的选项
h_submenu0=uimenu(h_menu1,'label','简单','callback',@simple_level);
h_submenu1=uimenu(h_menu1,'label','中等','callback',@middle_level);
h_submenu2=uimenu(h_menu1,'label','困难','callback',@hard_level);
h_submenu3=uimenu(h_menu1,'label','自定义难度','callback',@customize_level);
```
注意到这里可以设置多个`uimenu`, 其显示的位置是从左到右, 按照你代码的顺序向右依次排列, 同样地, 下拉的顺序与你设置`submenu`的先后顺序也保持一致, 

  [1]: https://raw.githubusercontent.com/ChangChunHe/Minesweeper/master/figure-uimenu.png
