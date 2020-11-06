function w = perc_train(x,y)

w = randn(1,size(x,2));
con = 0;

while con < size(x,1)
    for i = 1:size(x,1)
        ytest = hardlims(x(i,:)*w');
        
        if(ytest~=y(i))
            con = 0;
            error = y(i) - ytest;
            w = w + (error*x(i,:));
            
        else
            con = con + 1;
            
        end
    end
end

end