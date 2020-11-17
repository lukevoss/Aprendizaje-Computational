function W=rbftrain(x,y,centros,anchuras)
fi = calcula_fi(x,centros,anchuras);
W = pseudinv(fi)*y';
end

