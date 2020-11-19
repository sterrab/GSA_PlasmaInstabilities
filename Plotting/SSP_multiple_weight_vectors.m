%% Plotting first two weight vectors
%clear all; close all; 

%Load workspace 
% load('Dispersion_Rate_BiMax_P6_N512_var0.01_mu0_beta0.5data_par.mat')
load('Dispersion_Rate_V2_P3_N512_0.01data_par.mat')

w_1 = w; 
w_2 = w2; 

figure; 
scatter(Xs*w_1, Xs*w_2, 60, growth, 'o','filled');
colormap(jet);
c1 = colorbar;
xlabel('$w_1^Tp_j$', 'Interpreter','latex','Fontsize',16,'FontWeight','bold')
ylabel('$w_2^Tp_j$', 'Interpreter','latex','Fontsize',16,'FontWeight','bold')
ylabel(c1,'Growth Rate','Interpreter','latex','Fontsize',16,'FontWeight','bold','Rotation',270);
c1.Label.Position(1) = 5;
ax = gca; 
ax.FontSize = 16; 
set(get(ax,'Title'),'Units','Normalized','Position',[.5,1.04])
set(gcf,'PaperUnits','inches','PaperSize',[8 8])

%Indicate % or Global Variation in Title
% title('1% parameter variation','Interpreter','latex','Fontsize',16,'FontWeight','bold')
% title('Global parameter variation','Interpreter','latex','Fontsize',16,'FontWeight','bold')

%Save Figure 
% saveas(gcf, ['SSP_BoT_globalvar_2D.fig'])
% saveas(gcf, ['SSP_BoT_globalvar_2D.pdf'])


%% 3D Surface plot of growth rate vs first two weight vectors

x = Xs*w_1;
y = Xs*w_2;
z = growth;

% Nonlinear curve fit for 2D active subspace 
f12 = fit( [x, y], z, 'poly12');

%Plot polynomial approximation
fig = figure;
plot(f12, [x,y], z);
colormap(jet);
c1 = colorbar;
title(['2D Sufficient Summary Plot (N = ' int2str(N) ')'],'Interpreter','latex','Fontsize',16,'FontWeight','bold')
xlabel('$w_1^T p_j$','Interpreter','latex','FontSize',16)
ylabel('$w_2^T p_j$','Interpreter','latex','FontSize',16)
zlabel('$\gamma(w_1^T p_j,\ w_2^T p_j)$','Interpreter','latex','FontSize',16)
ylabel(c1,'Growth Rate','Interpreter','latex','Fontsize',16,'FontWeight','bold','Rotation',270);
c1.Label.Position(1) = 5;
set(get(gca,'Title'),'Units','Normalized','Position',[.5,1.04])
set(gcf,'PaperUnits','inches','PaperSize',[8 8])
view([-10, 30])
ax = gca; 
ax.FontSize = 16; 

%axis square;
grid on;
% set(fig,'PaperUnits','inches','PaperSize',[11 8])

%Compute and plot polynomial approximation & errors
error = abs(growth - f12(x,y));
l2err = error'*error;

%Save Figure
% saveas(gcf, ['SSP2_Dispersion_512_global_new.fig'])
% saveas(gcf, ['SSP2_Dispersion_512_global_new.pdf'])
% saveas(gcf, ['SSP2_Dispersion_512_global_new'], 'epsc')


%% Plotting first three weight vectors
w_3 = U(:,3); 

figure; 
scatter3(Xs*w_1, Xs*w_2, Xs*w_3, 60, growth, 'o', 'filled');
colormap(jet);
c2 = colorbar;
xlabel('$w_1^Tp_j$', 'Interpreter','latex','Fontsize',16,'FontWeight','bold')
ylabel('$w_2^Tp_j$', 'Interpreter','latex','Fontsize',16,'FontWeight','bold')
ylabel(c2,'Growth Rate','Interpreter','latex','Fontsize',16,'FontWeight','bold', 'Rotation',270);
zlabel('$w_3^Tp_j$', 'Interpreter','latex','Fontsize',16,'FontWeight','bold')
c2.Label.Position(1) = 5;
view([-10, 30])
ax = gca; 
ax.FontSize = 16; 

%Indicate % or Global Variation in Title
% title('1% parameter variation','Interpreter','latex','Fontsize',16,'FontWeight','bold')
% title('Global parameter variation','Interpreter','latex','Fontsize',16,'FontWeight','bold')


%Save Figure
% saveas(gcf, 'SSP_V2_25%var_3D.fig')
% saveas(gcf, 'SSP_V2_25%var_3D.pdf')
% saveas(gcf, 'SSP_V2_25%var_3D', 'epsc')


