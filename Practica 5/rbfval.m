function y=rbfval(x,centros,anchuras,W)
fi = calcula_fi(x,centros,anchuras);
y = (fi * W)';
end

