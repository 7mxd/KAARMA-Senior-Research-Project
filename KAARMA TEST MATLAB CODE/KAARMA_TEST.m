clc
clear

fprintf("Initialize: \n");
%Initialization
n_u = input("input dimension n_u: ");
n_s = input("state dimension n_s: ");
n_y = input("output dimension n_y: ");
n_x = n_s - n_y;
a_s = input("state kernel parameter a_s: ");
a_u = input("input kernel parameter a_u: ");
n = input("learning rate: ");
u{1} = [3]; % u(1) instead of u(0)         % randi([-9999, 9999], 1, n_u);
u{2} = [1]; % This is an input , u(2) instead of u(1)
s{1} = [4 2]; % s(1) instead of s(-1)      % randi([-9999, 9999], 1, n_s); 
s{2} = [2 1]; % s(2) instead of s(0)       % randi([-9999, 9999], 1, n_s);
A = [1 2];                                 % randi([-9999, 9999], 1, n_s);
feature_mat = FeatureMatrix(s{1}, u{1}); % Feature matrix
S{1} = [s{1}]; % State Dictionary
m = 1; % Dictionary size
I = [zeros(n_y, n_x), eye(n_y, n_y)]; % measurement matrix

% Computation
for t = 1 : 1 % instead of 2 we should have n, which is number of input-output pairs
    % Initialization 
    psi_prime = []; % feature matrix update
    S_prime = []; % state matrix update
    V{1} = eye(n_s, n_s); % To call V{1}(:,1) or V{1}(:,2)
    % Update State-Transition Gradient Matrix
    for i = 1 : t
        % Generate Next State
        s{i+2} = (CalculateOmega(s, u, A, m)')*FeatureMatrix(s{i+1}, u{i+1});
        % Update State Gradient
        D{i} = CalculateD(S, s, m, i);
        [~, K{i}] = eig(feature_mat'*FeatureMatrix(s{i+1}, u{i+1}));
        Lambda{i} = 2*a_s*(A').*K{i}.*(D{i}'); % If I use D{i} I get wrong value
        V{i} = CalculateVi(i, n_s, Lambda, V);
        % Update Feature and State Matrices
        psi_prime = [psi_prime, FeatureMatrix(s{i+1}, u{i+1})]; 
        S_prime = [S_prime, s{i+1}]; % state matrix update
    end
    % Prediction
    y(t)= I*s{t+2}; % I believe it is a single value, not a vector. Check eq. (13).
    
end
    

