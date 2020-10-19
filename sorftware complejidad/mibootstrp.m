function [xboot,indices]=mibootstrp(nboot,dummy,x)

N=length(x);
aux=rand(nboot,N);
aux=1+floor(aux*N);

xboot=x(aux);
indices=aux';
