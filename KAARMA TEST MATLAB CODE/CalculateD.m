function D = CalculateD(S, s, m, i)

for j = 1:m
    Temp_D{j} = S{j} - s{i+1};
end

D = cell2sym(Temp_D);

% Example to explain what I am doing: 
% A = {[1 2 3], [2 4], [5 6]};
% C = cell2sym(A)

end
