function V = Quantization(I)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%An image I is stacked in a column vector V
% I is a matrix
% V is a vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[height width] = size(I);
for i = 1:width
    for j = 1:height
        V(i*height + j) = I(j,i);
    end
end