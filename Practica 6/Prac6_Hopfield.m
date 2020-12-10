close all
clear all

Patrones = [1 -1 -1 1 -1 1 1 1 1 1 -1 -1 1 1 -1 1 1 -1 1 -1 1 1 -1 1 1;
            -1 1 1 1 -1 1 -1 1 -1 1 1 1 -1 1 1 1 -1 1 -1 1 -1 1 1 1 -1;
            1 1 1 -1 1 1 1 -1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 -1 -1 1 1];

npat = size(Patrones,1);
tam = size(Patrones,2);

W = zeros(tam,tam);

for i = 1:npat
    W = W + (Patrones(i,:).' * Patrones(i,:) - eye(tam));
end


Input = [-1 1 1 1 1 1 -1 1 -1 1 1 1 1 1 1 1 -1 1 -1 1 1 1 1 1 1];

stable = 0;
SPrev = Input;
while stable ~= 1
    S = SPrev * W;
    S = S ./ abs(S);
    if isequal(S,SPrev)
        stable = 1;
    else
        SPrev = S;
    end
end

d = draw_matrix(Patrones(1,:),5);
figure
image(d)
title('1er Patrón guardado')
colorbar

d = draw_matrix(Patrones(2,:),5);
figure
image(d)
title('2º Patrón guardado')
colorbar

d = draw_matrix(Patrones(3,:),5);
figure
image(d)
title('3er Patrón guardado')
colorbar

d = draw_matrix(Input,5);
figure
image(d)
title('Input: Patrón incompleto')
colorbar

d = draw_matrix(S,5);
figure
image(d)
title('Output: Patrón reconocido (2º patrón guardado)')
colorbar

