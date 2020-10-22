function gamma = dispersion_growthrate_BiMax(p)
% Calculating growth rate (imaginary component of angular frequency omega) using
% explicit root finding method for dispersion relation.
% ---Requires "zetaf.m" - representation of Z function
% ---Input p is a 6-parameter array

% BiMaxwellian/Bump-on-Tail
% p =  [k; mu_1; mu_2; sigma2_1; sigma2_2; beta]; 

k = p(1); %wavenumber
mu_1 =  p(2); mu_2  = p(3) ; %mean velocities
sigma2_1 = p(4) ; sigma2_2 = p(5) ; %thermal velocities
beta_1 = p(6) ; beta_2 =  1- beta_1; %scaling parameters

% Ai(z) = (z-mu_i)/(sqrt(2*sigma2_1)); z = omega/k = zr + i*zi
A1 = @(zr, zi) (1/(sqrt(2*sigma2_1)))*(zr + 1i*zi- mu_1);
A2 = @(zr, zi) (1/(sqrt(2*sigma2_2)))*(zr + 1i*zi- mu_2);
% Dispersion relation for the BiMaxwellian distribution in terms of A1(z), A2(z)
F = @(z) [real(1+(beta_1/(sigma2_1*k^2))*(1+A1(z(1),z(2))*zetaf(A1(z(1),z(2))))+(beta_2/(sigma2_2*k^2))*(1+A2(z(1),z(2))*zetaf(A2(z(1),z(2))))); 
            imag(1+(beta_1/(sigma2_1*k^2))*(1+A1(z(1),z(2))*zetaf(A1(z(1),z(2))))+(beta_2/(sigma2_2*k^2))*(1+A2(z(1),z(2))*zetaf(A2(z(1),z(2)))))];

% Solving the Dispersion relation 
guess_real = 1; 
guess_imag = 0.5; 

z_r1 = fsolve(F, [guess_real, guess_imag]);

% Growthrate: gamma = Im{omega} = k * Im{z}
gamma = k*z_r1(2); 

       