%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Map 7668 voxels back to 10000 voxels domain, and plot components%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('./Results_synfMRI')
addpath('./PlotCode')
addpath('./SynfMRIspatialmaps')
load brain_mask_conference.mat ind_brain

% Load your estimates, for example:
load test_z_earlystop.mat test_z

% Start mapping and ploting
SM = zeros(16,10000);
SM(:,ind_brain) = test_z';

showSMsyn_modified(SM,[2,8],0);
