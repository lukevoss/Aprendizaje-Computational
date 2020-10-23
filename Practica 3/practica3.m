close all
clear all

A = importdata('wine.data');
meanArray = kmeans(A, 13);
plot(meanArray,'o')