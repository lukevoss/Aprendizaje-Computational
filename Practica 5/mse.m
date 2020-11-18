function mse = mse(a,b)
%mse calculates the mean square error between the two arrays a and b of the same size.
%returns -1 if an error accured.
size = numel(a);
mse = -1;
if size == numel(b)
    mse = 0;
    for i = 1:size
        mse = mse + (a(i)-b(i))^2;
    end
    mse = mse/size;
end
end

