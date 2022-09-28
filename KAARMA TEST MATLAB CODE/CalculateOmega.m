function Omega = CalculateOmega(s, u, A, m)

for i = 1:m
    psi(:, i) = FeatureMatrix(s{i}, u{i});
end

Omega = psi*A;

end