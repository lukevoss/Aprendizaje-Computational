function network = train_network(network, train, l_rate, n_epoch, n_outputs, colum_of_solution)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
for epoch = 1:n_epoch
    sum_error = 0;
    for row_index = 1:(size(train,1))
        [network, outputs]=forward_propagate(network,train(row_index,:));
        expected = zeros(1,n_outputs);
        expected(train(row_index,colum_of_solution))=1;
        for i = 1:length(expected)
            sum_error = sum_error + (expected(i)-outputs(i))^2;
        end
        network = backward_propagate_error(network, expected);
        network = update_weights(network, (train(row_index,:)), l_rate);      
    end
    %epoch
    %sum_error
    disp("-----------------------")
    disp(epoch)
    disp(l_rate)
    disp(sum_error)
end
end
