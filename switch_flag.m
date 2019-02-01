function switch_flag(src,~)
global N flag_val h h_flagbox h_flag circum
squ_size = 500/N;
figHandle = ancestor(src, 'figure');
clickType = get(figHandle, 'SelectionType');
if strcmp(clickType, 'alt')
    idx = str2double(get(src,'tag'));
    c = ceil(idx/N);r = mod(idx,N);r(r==0) = N;
    I = imread('flag.jpg');hold on;I = imresize(I,floor([squ_size squ_size]*0.75));
    if flag_val(r,c) % remove flag
        set(h(r,c),'visible','on')
        delete(h_flag(r,c))
        flag_val(r,c) = 0;
        set(h_flagbox,'string',num2str(str2double(get(h_flagbox,'string'))+1))
    else % set a flag
        if str2double(get(h_flagbox,'string')) == 0 
            % if all flags have been used, return
            return
        end
        set(h(r,c),'visible','off')
        h_flag(r,c) =  image([(c-1)*squ_size c*squ_size],...
            [(N-r+1)*squ_size (N-r)*squ_size],I,'ButtonDownFcn',@switch_flag,'tag',num2str((c-1)*N+r));
        flag_val(r,c) = 1;
        set(h_flagbox,'string',num2str(str2double(get(h_flagbox,'string'))-1))
    end
    if str2double(get(h_flagbox,'string')) == 0 && all(circum(ishandle(h_flag)) == 9) 
        % have already found all bombs
        win_game = uicontrol('Style','text', 'Units','pixels',...
            'Position',[6*squ_size,(N+1)*squ_size+4,2*squ_size,squ_size],...
            'String','Win','fontsize',18, 'BackgroundColor',get(gcf,'color'));
    end
end