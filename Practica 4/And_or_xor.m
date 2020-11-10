% Perceptrón para modelar las funciones lógicas AND y OR
close all;
clear all;

% Al primero vamos a crear las Datos de OR y AND:
X = [0 0 1 1;
    1 0 1 0];
Y_or = [1 -1 1 1];
Y_and = [-1 -1 1 -1];
Y_xor = [1 -1 -1 1];

%configurar el plot por OR
figure('Name','OR Function','NumberTitle','off');
classA = find(Y_or == -1);
classB = find(Y_or == 1);
plot(X(1,classA), X(2,classA), 'o', 'LineWidth', 2, 'MarkerSize', 10)
hold on
plot(X(1,classB), X(2,classB), 'rx', 'LineWidth', 2, 'MarkerSize', 10);
axis([min(X(:))-1, max(X(:)+1), min(X(:))-1, max(X(:)+1)]);
set(gca, 'FontSize', 16);
grid;

%crea una recta aleatoria por OR
W = perceptrain(X,Y_or);
X_aux = [min(X(:))-1 : 0.5 : max(X(:)+1)];
Y_aux = -(W(1)/W(2))* X_aux - W(3)/W(2);
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

%crea una recta aleatoria por AND
W = perceptrain(X,Y_and);
X_aux = [min(X(:))-1 : 0.5 : max(X(:)+1)];
Y_aux = -(W(1)/W(2))* X_aux - W(3)/W(2);
plot(X_aux, Y_aux, 'k', 'LineWidth', 2);
hold off;

%configurar el plot por XOR
figure('Name','XOR Function','NumberTitle','off');
classA = find(Y_xor == -1);
classB = find(Y_xor == 1);
plot(X(1,classA), X(2,classA), 'o', 'LineWidth', 2, 'MarkerSize', 10)
hold on
plot(X(1,classB), X(2,classB), 'rx', 'LineWidth', 2, 'MarkerSize', 10);
axis([min(X(:))-1, max(X(:)+1), min(X(:))-1, max(X(:)+1)]);
set(gca, 'FontSize', 16);
grid;



%hacer el entrenamiente del perceptrón y plotar lo
W = perceptrain(X,Y_xor);
X_aux = [min(X(:))-1 : 0.5 : max(X(:)+1)];
Y_aux = -(W(1)/W(2))* X_aux - W(3)/W(2);
plot(X_aux, Y_aux, 'k', 'LineWidth', 2);
hold off;



