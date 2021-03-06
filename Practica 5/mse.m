function mserror = mse(a,b)
%mse calculates the mean square error between the two arrays a and b of the same size.
%returns -1 if an error accured.
size = numel(a);
mserror = -1;
if size == numel(b)
    mserror = 0;
    for i = 1:size
        mserror = mserror + (a(i)-b(i))^2;
    end
    mserror = mserror/size;
end
end

