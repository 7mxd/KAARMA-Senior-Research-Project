function feature_mat = FeatureMatrix(s,u)

% initiating two variables based on vector s
u1 = sym('u', size(s));
c1 = sym('c', size(s));


% getting the s vector mapped into the RKHS
K_s = expand((1 + dot(u1,c1))^2); % we expand the polynomial kernel 
coef = sqrt(coeffs(K_s)); % we get the coefficients square rooted
coef2 = coeffs(K_s); % we get the coefficients without being square rooted
coef_c = coeffs(K_s, c1); % we get the coefficients w.r.t c
map_s = subs(coef_c ./ coef2 .* coef, u1, s); % (coef_c / coef2) to get rid 
% of the not square rooted coefficients and then multiply by the square
% rooted coefficients, and replace u by s vector

% -----------------------------------------------------

% initiating two variables based on vector u
u2 = sym('u', size(u));
c2 = sym('c', size(u));


% getting the s vector mapped into the RKHS
K_u = expand((1 + dot(u2,c2))^2); % we expand the polynomial kernel 
coef = sqrt(coeffs(K_u)); % we get the coefficients square rooted
coef2 = coeffs(K_u); % we get the coefficients without being square rooted
coef_c = coeffs(K_u, c2); % we get the coefficients w.r.t c
map_u = subs(coef_c ./ coef2 .* coef, u2, u); % (coef_c / coef2) to get rid 
% of the not square rooted coefficients and then multiply by the square
% rooted coefficients, and replace u by s vector

% -----------------------------------------

% Calculate the tensor product
feature_mat = (kron(map_s, map_u))';
end
