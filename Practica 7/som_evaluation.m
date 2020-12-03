function class = som_evaluation(data,w)
N = size(data,2);
M = size(w,2);
distancias = zeros(1,M);
class = zeros(1,N);
for i=1:N
        % Obtener Best Match
        for j=1:M
            distancias(j)=sumsqr(w(:,j)-data(:,i));
        end
        [ ~,best]=min(distancias);
        class(i) = best;
end
end


