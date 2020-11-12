% Perceptrón para modelar las funciones lógicas AND y OR
close all;
clear all;

xtest = 3*rand(2,1000)-1;

% Al primero vamos a crear las Datos de OR, AND, NOT y XOR:
X = [0 0 1 1;
    1 0 1 0];
X_not = [1 0];
Y_or = [1 -1 1 1];
Y_and = [-1 -1 1 -1];
Y_not = [-1 1];
Y_xor = [1 -1 -1 1];

%crear not funcion para ser capaz de negar los resultos
W_not = perceptrain(X_not, Y_not);

%configurar el plot por OR
figure('Name','OR Function','NumberTitle','off');
classA = find(Y_or == -1);
classB = find(Y_or == 1);
hold on;
plot(X(1,classA), X(2,classA), 'o', 'LineWidth', 2, 'MarkerSize', 10)
plot(X(1,classB), X(2,classB), 'rx', 'LineWidth', 2, 'MarkerSize', 10);
axis([min(X(:))-1, max(X(:)+1), min(X(:))-1, max(X(:)+1)]);
set(gca, 'FontSize', 16);
grid;

%hacer el entrenamiento del perceptrón por OR
W_or = perceptrain(X,Y_or);
X_aux = [min(X(:))-1 : 0.5 : max(X(:)+1)];
Y_aux = -(W_or(1)/W_or(2))* X_aux - W_or(3)/W_or(2);
plot(X_aux, Y_aux, 'k', 'LineWidth', 2);
hold off;

%configurar el plot por AND
figure('Name','AND Function', 'NumberTitle','off');
classA = find(Y_and == -1);
classB = find(Y_and == 1);
plot(X(1,classA), X(2,classA), 'o', 'LineWidth', 2, 'MarkerSize', 10)
hold on
plot(X(1,classB), X(2,classB), 'rx', 'LineWidth', 2, 'MarkerSize', 10);
axis([min(X(:))-1, max(X(:)+1), min(X(:))-1, max(X(:)+1)]);
set(gca, 'FontSize', 16);
grid;

%hacer el entrenamiente del perceptrón por AND
W_and = perceptrain(X,Y_and);
X_aux = [min(X(:))-1 : 0.5 : max(X(:)+1)];
Y_aux = -(W_and(1)/W_and(2))* X_aux - W_and(3)/W_and(2);
plot(X_aux, Y_aux, 'k', 'LineWidth', 2);
hold off;

%crear function XOR con las otras funciones y darle datos aleatorios:
ytest = ones(1, length(xtest));
for i = 1:length(ytest)
    y1 = hardlims([xtest(:,i);1]' * W_or);
    y2 = hardlims([xtest(:,i);1]' * W_and);
    y3 = hardlims([y2;1]' * W_not);
    ytest(i) = hardlims([y1; y3; 1]' * W_and);
end

%configurar el plot por XOR
figure('Name','XOR Function','NumberTitle','off');
classA = find(Y_xor == -1);
classB = find(Y_xor == 1);
hold on;
plot(X(1,classA), X(2,classA), 'o', 'LineWidth', 2, 'MarkerSize', 10) 
plot(X(1,classB), X(2,classB), 'rx', 'LineWidth', 2, 'MarkerSize', 10)

%monstrar los rectas calculadas
X_aux = [min(X(:))-1 : 0.5 : max(X(:)+1)];
Y_aux = -(W_and(1)/W_and(2))* X_aux - W_and(3)/W_and(2);
plot(X_aux, Y_aux, 'k', 'LineWidth', 2);
X_aux2 = [min(X(:))-1 : 0.5 : max(X(:)+1)];
Y_aux2 = -(W_or(1)/W_or(2))* X_aux - W_or(3)/W_or(2);
plot(X_aux2, Y_aux2, 'k', 'LineWidth', 2);

%monstrar conjuntos de verdadero y falso de XOR:
classTrue = find(ytest == 1);
classFalse = find(ytest == -1);
plot(xtest(1,classTrue), xtest(2,classTrue), 'rx', 'LineWidth', 1, 'MarkerSize', 3);
plot(xtest(1,classFalse), xtest(2,classFalse), 'bx', 'LineWidth', 1, 'MarkerSize', 3);
hold off;
axis([min(X(:))-1, max(X(:)+1), min(X(:))-1, max(X(:)+1)]);
set(gca, 'FontSize', 16);
grid;


