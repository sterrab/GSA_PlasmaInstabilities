# GSA_PlasmaInstabilities
Global Sensitivity Analysis (GSA) of Plasma Instabilities - Two-Stream and BiMaxwellian equilibria considered

Authors: Soraya Terrab and Stephen Pankavich, Department of Applied Mathematics and Statistics, Colorado School of Mines

The growth rates of the Two-Stream and BiMaxwellian equilibrium distributions are computed by solving for roots for their respective dispersion relations. A global sensitivity analysis (GSA) of the growth rate is conducted using active subspace decompositions, given average parameters (wavespeed k, mean velocity mu, thermal velocity sigma_2, scaling parameter beta) and percentage variation, by running N=512 simulations.

Filename zetaf.m (Ref: M. Zaghloul & A. Ali (2011)) is a numerical evaluation of the plasma Z-function. 
Solutions of the dispersion relations of the Two-Stream and BiMaxwellian distributions are included in functions "dispersion_growthrate_V2TwoStream.m" and "dispersion_growthrate_BiMax.m", respectively. 

The Global Sensitivity Analysis can be conducted through the script files "Global_Sensitivity_PIC_VP_V2TwoStream_dispersion_rate_p3.m" and "Global_Sensitivity_PIC_VP_BiMax_dispersion_rate_p6.m". The output workspaces can be loaded and figures may be created using "Global_Sens_Plots_from_Data_Instability.m". 
