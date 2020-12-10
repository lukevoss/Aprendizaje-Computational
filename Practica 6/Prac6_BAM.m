close all
clear all

PX = [1 -1 -1 1 -1 1 1 1 1 1 -1 -1 1 1 -1 1 1 -1 1 -1 1 1 -1 1 1;
      -1 1 1 1 -1 1 -1 1 -1 1 1 1 -1 1 1 1 -1 1 -1 1 -1 1 1 1 -1;
      1 1 1 -1 1 1 1 -1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 -1 -1 1 1];
tamx = size(PX,2);

PY = [1 -1 1 -1 1 -1 1 -1 1; -1 1 -1 1 -1 1 -1 1 -1; -1 1 -1 -1 1 1 1 -1 -1];
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

Input = [1 1 1 -1 1 1 1 -1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 -1 -1 1 1];

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

d = draw_matrix(PX(1,:),5);
figure
image(d)
title('1ª pareja de patrones guardados (X)')
colorbar

d = draw_matrix(PY(1,:),3);
figure
image(d)
title('1ª pareja de patrones guardados (Y)')
colorbar

d = draw_matrix(PX(2,:),5);
figure
image(d)
title('2ª pareja de patrones guardados (X)')
colorbar

d = draw_matrix(PY(2,:),3);
figure
image(d)
title('2ª pareja de patrones guardados (Y)')
colorbar

d = draw_matrix(PX(3,:),5);
figure
image(d)
title('3ª pareja de patrones guardados (X)')
colorbar

d = draw_matrix(PY(3,:),3);
figure
image(d)
title('3ª pareja de patrones guardados (Y)')
colorbar

d = draw_matrix(Input,5);
figure
image(d)
title('Input: Patrón a emparejar (X)')
colorbar

d = draw_matrix(YNew,3);
figure
image(d)
title('Input: Patrón pareja encontrado (Y)')
colorbar
