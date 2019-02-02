# 计时器

MATLAB 中有一个`timer`的东西可以构建一个计时器, 例如下面这个例子.
```matlab
time_ui = timer('StartDelay',0,'TimerFcn',@time_tool,...
    'Period',1,'ExecutionMode','fixedRate');
```
这里的`TimeFcn`后面跟的就是`timer`这个函数会不停调用的函数, 这里的`Period`等于1就表示每隔一秒调用一次, 例如我们设置一个计数的变量`count`, 每调用一次就加一, 那么就可以实现精确到秒的计时了. 注意到前面这个`StartDeley`这个参数, 设置成0表示开始执行这个参数是没有延迟的, 但是这个在暂停开始计时时会出现一些问题.例如下面这个例子
```matlab
clear;clc;close all
global h_clock num h time_ui
h_clock = uicontrol('FontSize',18,'FontWeight','bold',...
    'position',[200 300 105 30], 'Style','text','string','0 : 0',...
    'BackgroundColor',get(gcf,'color'));
time_ui = timer('StartDelay',0,'TimerFcn',@time_tool,...
    'Period',1,'ExecutionMode','fixedRate');
num = 0;
start(time_ui)
h = uicontrol('FontSize',18,'FontWeight','bold',...
'position',[100 200 105 30],'Style','pushbutton','string','Pause',...
    'BackgroundColor',get(gcf,'color'),'callback',@pause_time);

function pause_time(~,~)
global time_ui h
stop(time_ui)
set(h,'callback',@continue_time,'string','continue')
% set(time_ui,'StartDelay',1)
end

function continue_time(~,~)
global time_ui h
start(time_ui)
set(h,'callback',@pause_time,'string','pause')
end

function time_tool(~,~)
global num h_clock
set(h_clock,'String',[num2str(floor(num/60)),' : ',num2str(num-floor(num/60)*60)])
num= num+ 1;
end
```
这里使用`start(time_ui), stop(time_ui)`可以分别开始停止`timer`函数的调用, 但是注意到当你点击暂停之后再点击继续的话就会发现计时器会多加一个. 这个由于`startdelay`设置为0的缘故, 因为重新开始马上调用一次就会多加一次, 所以我们在开始之后将`startdelay`设置回1(更准确的说是与你的周期(`period`)保持一致)就可以了, 也就是把上面的代码中, 函数`pause_time`中的注释关闭掉就可以了.
