function drawmat = draw_matrix(v,t)

drawmat = zeros(size(v,2)/t,t);
s = 1;
for i = 1:size(v,2)/t
    drawmat(i,:) = v(s:t*i);
    s = s + t;
end
drawmat = drawmat .* 100;

end