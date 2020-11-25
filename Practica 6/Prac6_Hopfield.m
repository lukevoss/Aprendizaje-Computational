close all
clear all

Patrones = [1 1 -1 -1; -1 -1 1 1];
npat = size(Patrones,1);
tam = size(Patrones,2);

W = zeros(tam,tam);

for i = 1:npat
    W = W + (Patrones(i,:).' * Patrones(i,:) - eye(tam));
end


Input = [1 -1 -1 -1];

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

draw_matrix(Patrones(1,:),2);
draw_matrix(Patrones(2,:),2);

draw_matrix(Input,2);
draw_matrix(S,2);

