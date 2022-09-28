function A = CalculateAk(n_s, A, n, I, V, i, e)

Temp_A = [];

for k = 1:n_s
    Temp_A(:, k) = [A(:, k) ; n*( I*V{i}(:, k) )'*e(i)];
end

A = Temp_A;

end