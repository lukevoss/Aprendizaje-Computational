function outputs = predict(network, row)
[network, outputs] = forward_propagate(network, row);
end

