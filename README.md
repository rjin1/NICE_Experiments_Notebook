# NICE_Experiments_Notebook

# 1. The 'NICE_SynGumbelSourceExperiment_Main.ipynb' contains all codes of NICE experiment on synthetic Gumbel sources.
1). The distribution parameters(stored in 'DistributionParams' folder) are obtained from maximum likelihood estimation on fMRI synthetic sources. The Gumbel sources are simulated using these parameters. The 'evfit' function is used for the implementation in the MATLAB.

2). The plot of correlation and histogram matching results after 100 epochs training is recorded for you to check. Just jump to last few lines to check them in the notebook. Results are not the early stopping results but already valid.

3). The default folder for storing results is 'Results_synGumbel'.

# 2. The 'NICE_SynfMRIspatialmapsExperiment_Main.ipynb' contains all codes of NICE experiment on synthetic fMRI sources(spatial maps).
1). The distribution parameters used in prior are same with the experiment above. 

2). fMRI sources are stored in 'SynfMRIspatialmaps'.

3). The default folder for storing results is 'Results_synfMRI'.

4). You can use 'ComponentPlot.m' to plot maps, this code contains unmasking and 2D visualization.
