function [si,no]=ainb(x,y)
%
% function [si,no]=ainb(x,y)
%
% Determina los elementos del conjunto y que est�n en el conjunto x
% Devuelve si: elementos que de y est�n en x
%          no: elementos de y que no est�n en x
%
%Ultima modificacion 15/5/02


x=tocol(x);
y=torow(y);

A=repmat(x,1,length(y));
B=repmat(y,length(x),1);

T=sum(A==B);

si=find(T~=0);
no=find(T==0);

