function gamma= dispersion_growthrate_V2TwoStream(p)
% Calculating growth rate (imaginary component of angular frequency omega) using
% explicit root finding method for dispersion relation.
% ---Requires "zetaf.m" - representation of Z function
% ---Input p is a 3-parameter array 

% V^2 Two-Stream  
% p =  [k; mu; sigma2]; 

k = p(1);  %wavenumber 
mu = p(2); %mean velocity
sigma2 = p(3); %thermal velocity
beta = 1; %scaling parameter

% A(z) = (z-mu)/(sqrt(2*sigma2)); z = omega/k = zr + i*zi
A = @(zr, zi) (1/(sqrt(2*sigma2)))*(zr + 1i*zi- mu);
% Dispersion relation of Two-Stream Equilibrium in terms of A(z)
F = @(z) [real(1 - (beta/(k^2))*(1 - 2*A(z(1), z(2))^2 + 2*(A(z(1), z(2)) - A(z(1), z(2))^3)*zetaf(A(z(1), z(2)))));
            imag(1 - (beta/(k^2))*(1 - 2*A(z(1), z(2))^2 + 2*(A(z(1), z(2)) - A(z(1), z(2))^3)*zetaf(A(z(1), z(2)))))];

% Solving the Dispersion relation 
guess_real = 0.5; 
guess_imag = 0.2585; 

z_r1 = fsolve(F, [guess_real,guess_imag]);

% Growthrate: gamma = Im{omega} = k*Im{z}
gamma = k*z_r1(2);
