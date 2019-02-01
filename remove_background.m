function I = remove_background(I)
idx = sum(I,3);
[row,col] = find(idx > 255+255+240);
for ii = 1:length(row)
    I(row(ii),col(ii),:) = [205; 197; 191];
end