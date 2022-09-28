function V = CalculateVi(i, n_s, Lambda, V) 
if i == 1
    V = eye(n_s, n_s);
elseif i>1
    I = eye(n_s, n_s);
    for k = 1:n_s
    V(:,k) = [Lambda{i}*V{i-1}(:,k), I(:,k)];
    end
end