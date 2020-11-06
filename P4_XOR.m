clc;
clear all;
close all;

x = [0 0 1; 1 0 1; 0 1 1; 1 1 1];
y1 = [-1; -1; -1; 1];   % AND
y2 = [-1; 1; 1; 1];     % OR

w1 = perc_train(x,y1);
w2 = perc_train(x,y2);

y = [-1; 1; 1; -1];     % XOR

for i = 1:size(x,1)
    if(y(i) == 1)
        plot(x(i,1),x(i,2),'*g','MarkerSize',10); hold on;
    else
        plot(x(i,1),x(i,2),'*r','MarkerSize',10); hold on;
    end
end

t = linspace(-1,2);
plot(t,(-w1(1) * t - w1(3)) / w1(2),'b'); axis([-1 2 -1 2]); hold on;
plot(t,(-w2(1) * t - w2(3)) / w2(2),'b'); axis([-1 2 -1 2]);


