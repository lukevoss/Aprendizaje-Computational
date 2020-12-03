function class = KOHNENval(red_data,w)
N = size(red_data,2);
M = size(w,2);
distancias = zeros(1,M);
class = zeros(1,N);
for i=1:N
        % Obtener BMU
        for j=1:M
            distancias(j)=sumsqr(w(:,j)-red_data(:,i));
        end
        [ ~,BMU]=min(distancias);
        class(i) = BMU;
end
end


