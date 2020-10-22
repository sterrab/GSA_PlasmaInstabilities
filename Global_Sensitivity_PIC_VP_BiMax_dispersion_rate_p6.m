rng('shuffle');
parpool(32);

% Initialize algorithm parameters
N = 512; %30   %Number of samples for each parameter
h = 1e-6;    %Finite difference step size

% Pre-allocate memory
growth = zeros(N,1);                        %Output of interest (growth rate)
Nparams = 6;
growth_plus = zeros(N,Nparams);             %Perturbed output of interest
grad_growth = zeros(Nparams,N);             %Gradient of output of interest 
Xs = zeros(N,Nparams);                    %To save the normalized paramters
                    

% Set upper and lower bounds for parameters
% vals =  [k; mu_1; mu_2; sigma2_1; sigma2_2; beta_1]; 
%setvals = [0.5; 0; 4.0; 0.5; 0.5; 0.8]; % Bump-on-Tail
setvals = [0.5; 0; 4.0; 0.5; 0.5; 0.5]; % Double-Beam 

var = 0.01; % x 100% variation considered 
xl = (1-var)*setvals;
xu = (1+var)*setvals;

xl(2) = -var ; 
xu(2) = var ;

% Run simulation
tic
parfor jj = 1:N
    rng(sum(100*clock)+pi*jj); 
    % Randomly sample parameters within acceptable ranges
    Xs(jj,:) = 2*rand(1,Nparams) - 1;
    params = 1/2*(diag(xu - xl)*Xs(jj,:)' + (xu + xl));
    % Numerically solve 1D Vlasov-Poisson with baseline parameters
    growth(jj) = dispersion_growthrate_BiMax(params);
    % Re-running solver if wrong roots (large positive) found
    while growth(jj) > 5 
        Xs(jj,:) = 2*rand(1,Nparams) - 1;
        params = 1/2*(diag(xu - xl)*Xs(jj,:)' + (xu + xl));
        growth(jj) = dispersion_growthrate_BiMax(params);
    end 
end

parfor jj = 1:N
    randparams = Xs(jj,:)';
    for kk = 1:Nparams
        I = eye(Nparams);                     
        % Numerically solve 1D Vlasov-Poisson with perturbed parameters
        xplus = randparams + h*I(:,kk);
        paramsplus = 1/2*(diag(xu - xl)*xplus + (xu + xl));
        growth_plus(jj, kk)= dispersion_growthrate_BiMax(paramsplus);
        % Re-running solver if wrong roots (large positive) found
        while growth_plus(jj,kk) > 5 
            xplus = randparams + h*I(:,kk);
            paramsplus = 1/2*(diag(xu - xl)*xplus + (xu + xl));
            growth_plus(jj, kk)= dispersion_growthrate_BiMax(paramsplus);
        end 
    end
end
parfor jj = 1:N
    % Calculate the appx gradients using finite differences
    grad_growth(:,jj) = (growth_plus(jj, :) - growth(jj))/h;
        
end
toc

% Compute the weights and eigenvalues

% Compute the singular value decomposition of the matrix C
[U,S,V] = svd(1/sqrt(N)*grad_growth);
w = U(:,1);
w2 = U(:,2);
    
%Compute the eigenvalues of C
evalues = diag(S.^2);
    
% Find the difference of max and min grad_growth to check for errors
diff_growth = max(max(grad_growth)) - min(min(grad_growth));
   
%Save the trial data
save(['Dispersion_Rate_BiMax_P' int2str(Nparams) '_N' int2str(N) '_var' num2str(var) '_mu' num2str(setvals(2)) '_beta' num2str(setvals(6)) 'data_par.mat'])

exit