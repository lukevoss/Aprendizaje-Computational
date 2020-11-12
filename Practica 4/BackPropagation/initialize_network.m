function network = initialize_network(n_inputs, n_hidden, n_outputs)
%n_inputs is the number of inputs
%n_hidden is the number of neurons in the hidden layer, each with n_inputs+1 weights
%(one for each input + bias)
%n_outputs is the number of outputs, each with n_hidden+1 weights
%(one for each neuron in hidden layer + bias)
%
% Returns array with weights
hidden_layer.weights=rand(n_hidden, n_inputs+1); %+1 for bias
hidden_layer.output=zeros(1,n_hidden);
hidden_layer.delta=zeros(1,n_hidden);
output_layer.weights=rand(n_outputs, n_hidden+1);%+1 for bias
output_layer.output=zeros(1,n_outputs);
output_layer.delta=zeros(1,n_outputs);
network.hidden_layer = hidden_layer;
network.output_layer = output_layer;
end

