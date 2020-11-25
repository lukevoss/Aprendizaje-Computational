close all
clear all

PX = [1 1 -1 -1; 1 -1 1 -1];
tamx = size(PX,2);

PY = [1 1 1 -1 -1 -1 -1 -1 -1; 1 -1 -1 1 -1 -1 1 -1 -1];
tamy = size(PY,2);

npat = size(PX,1); % npat_x = npat_y
W = zeros(tamx,tamy);

for i = 1:npat
    for j = 1:tamx
        for k = 1:tamy
            W(j,k) = W(j,k) + PX(i,j) * PY(i,k);
        end
    end
end
W = W ./ npat;

Input = [1 1 -1 -1];

stable = 0;
XPrev = Input;
YPrev = [];
while stable ~= 1
    YNew = XPrev * W;
    YNew = YNew ./ abs(YNew);
    XNew = YNew * W';
    XNew = XNew ./ abs(XNew);
    if isequal(YNew,YPrev)
        stable = 1;
    else
        XPrev = XNew;
        YPrev = YNew;
    end
end

draw_matrix(PX(1,:),2);
draw_matrix(PY(1,:),3);

draw_matrix(Input,2);
draw_matrix(YNew,3);