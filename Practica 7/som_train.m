function w = som_train(x,w,iter,vec,a_inicial,r_inicial)
w_prev = w;
counter = 0;
terminado = 0;
%entrada
N = size(x,2);
%capa de salida
M = size(w,2);
d = zeros(1,M);
while counter<=iter && ~terminado
    counter = counter+1;
    a = a_inicial * ( 1 - (counter / iter) );
    r = round(r_inicial * ( 1 - (counter / iter) ));
    for i=1:N %find best fit
        for j=1:M
            d(j)=sumsqr(w(:,j)-x(:,i));
        end
        [ ~,best]=min(d);
        update = x(:,i) - w(:,best);
        inc = repmat(update,1,M);
        omega = zeros(1,M);
        indices = find(vec(best,:)<=r);
        for k = indices
            omega(k)= 1 / exp(vec(best,k)');
        end
        omega = repmat(omega,size(w,1),1);
        suma = (a * omega .* inc);
        w = w + suma;
    end
    if w_prev ~= w
        w_prev = w;
    else
        terminado = true;
    end
    figure(1)
    plot(x(1,:),x(2,:),'g.')
    hold on
    plotsom(w(1:2,:)',vec);
    title('Self organizing map');
    hold off
    drawnow;
end