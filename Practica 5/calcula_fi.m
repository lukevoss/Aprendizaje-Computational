function fi=calcula_fi(x,centros,anchuras)
if size(anchuras,2)==1
 varianzas=anchuras * ones(1,size(centros,2));
else
 varianzas=anchuras;
end
fi(size(x,2),size(centros,2))=0;
for i=1:size(centros,2)
 fi(:,i)=normpdf(x,centros(:,i),varianzas(i))';
end
