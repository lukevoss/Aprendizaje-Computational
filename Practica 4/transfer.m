function sig_activation = transfer(activation)
    sig_activation = 1/(1+exp(-activation));
end