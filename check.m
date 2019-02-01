function check(src,~)
global N circum h
tag = str2double(get(src,'Tag'));%把字符串转成数字
row=ceil(tag/N);
col = rem(tag,N);col(col==0)=N;boom=[];
I = imread('boom.jpg');squ_size = 500/N;
I = imresize(I,floor([squ_size squ_size]*0.8));
if circum(row,col)==9
    for i=1:N
        for j=1:N
            boom=[boom;i,j];
            boom(circum(sub2ind(size(circum),boom(:,1),boom(:,2)))~=9,:) = [];
        end
    end
    for i=1:size(boom,1)
        delete(h(sub2ind(size(circum),boom(i,2),boom(i,1))));
        tmp_row = boom(i,1); tmp_col = boom(i,2);
        drawnow
        hold on;image([squ_size*(tmp_col-1) squ_size*tmp_col],[N*squ_size-(tmp_row-1)*squ_size N*squ_size-tmp_row*squ_size],I)
    end
    %cancel uicontrols
    for i=1:N^2
        try
            set(h(i),'callback','')
        end
    end
elseif circum(row,col)==0
    cen = [row col];
    near=[1 0;0 1;0 -1;-1 0];
    edge = repmat(cen,4,1) + near;
    edge(edge(:,1)<1|edge(:,1)>N|edge(:,2)<1|edge(:,2)>N,:) = [];
    edge(circum(sub2ind(size(circum),edge(:,1),edge(:,2)))~=0,:) = [];
    while ~isempty(edge)
        cen = [cen;edge];
        edge = [];
        for ii = 1:size(cen,1)
            edge = [edge; repmat(cen(ii,:),4,1) + near];
        end
        edge = setdiff(edge,cen,'rows');
        edge(edge(:,1)<1|edge(:,1)>N|edge(:,2)<1|edge(:,2)>N,:) = [];
        edge(circum(sub2ind(size(circum),edge(:,1),edge(:,2)))~=0,:) = [];
    end
    for i=1:size(cen,1)
        set(h(sub2ind(size(circum),cen(i,2),cen(i,1))),'Style','text','string',[],'BackgroundColor',[205 197 191]/255);
    end
    edge = [];
    for ii = 1:size(cen,1)
        edge = [edge; repmat(cen(ii,:),4,1) + near];
    end
    edge = setdiff(edge,cen,'rows');
    edge(edge(:,1)<1|edge(:,1)>N|edge(:,2)<1|edge(:,2)>N,:) = [];
    for i=1:size(edge,1)
        delete(h(sub2ind(size(circum),edge(i,2),edge(i,1))))
        h((sub2ind(size(circum),edge(i,2),edge(i,1)))) = text((edge(i,2)-0.5)*squ_size,...
            (N+0.5-edge(i,1))*squ_size,num2str(circum(edge(i,1),edge(i,2))),...
            'fontsize',18,'HorizontalAlignment','center');
    end
else %circum(row,col)~=9&&circum(row,col)~=0
    delete(h(sub2ind(size(circum),col,row)))
    h((sub2ind(size(circum),col,row))) = text((col-0.5)*squ_size,(N+0.5-row)*squ_size,num2str(circum(row,col)),...
        'fontsize',18,'HorizontalAlignment','center');
end
