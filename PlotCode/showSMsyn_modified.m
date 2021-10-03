function F = showSMsyn_modified(SM, DIMS, Scaleindex, Colorlimits)
%   simtb_showSM()  - Plot SMs
%  
%   Usage:
%    >> F = simtb_showSM(SM, CMAP, 'figname', DIMS, CBAR_flag)
%
%   INPUTS: 
%   SM            = SMs, size = [number of SM x number of voxels]
%   CMAP          = colormap, as a string or [M x 3] matrix (OPTIONAL)
%   figname       = Name of figure (OPTIONAL)
%   DIMS          = subplot dimensions, [nRow, nCol] (OPTIONAL)
%   CBAR_flag     = 0|1, 1 include colorbar (OPTIONAL, default = 1)
%   Scaleindex = 1, 1 indicates proportional scaling to Colorlimits (3/22/2021 by Rui)
%   Colorlimits  = [min(a negative value), max], Negative values in SM are proportionally scaled to min~0, non-negative values in SM to 0~max. (3/22/2021 by Rui)
%
%   OUTPUTS:
%   F             = Figure handle
%
% see also: simtb_showSMContours()

%--------------------------------------------------------------------------
% Check Inputs
%--------------------------------------------------------------------------
if isvector(SM)
    SM = SM(:)'; % make sure it's a row vector
elseif ndims(SM) == 2 && size(SM,1) == size(SM,2)
    SM = SM(:)'; % convert from square to row vector
end

CMdata = load('CM_coldhot_256');
CMAP = CMdata.CM;

figname = '';

[nC, nVV] = size(SM);
nV = sqrt(nVV);

maxnCOL = 10;
if nC > maxnCOL
    nROW = ceil(nC/maxnCOL);
else
    nROW = 1;
end
nCOL = ceil(nC/nROW);
if prod(DIMS) < nC
    error('Subplot dimensions must be equal or greater to the number of SMs')
else
    nROW = DIMS(1);
    nCOL = DIMS(2);    
end

CBAR_flag = 1;


%%
%SM scaling
%(3/22/2021 by Rui)
if Scaleindex == 1
    for n_ind = 1:nC
%         SM_C = SM(n_ind, :);
%         SM_Ctemp = SM_C;
%         %Proportional scaling to colorlimits (different scaling degree for non-negative values and negative values in the input data.
%         %Non-negative values
%         SM_nonnega_ind = SM_C>=0;
%         if max(max(SM_C(SM_nonnega_ind)))==0
%             SM_Ctemp(SM_nonnega_ind)=0;
%         else
%             SM_Ctemp(SM_nonnega_ind) = (SM_C(SM_nonnega_ind)./max(max(SM_C(SM_nonnega_ind)))).*Colorlimits(2);
%         end
%         %Negative values
%         SM_nega_ind = SM_C<0;
%         SM_Ctemp(SM_nega_ind) = (SM_C(SM_nega_ind)./max(max(abs(SM_C(SM_nega_ind))))).*abs(Colorlimits(1));
%         SM(n_ind, :) = SM_Ctemp;
            SM(n_ind,:) = SM(n_ind,:) ./ max(abs(SM(n_ind,:)));
    end
end




%--------------------------------------------------------------------------
% Plot SMs
%--------------------------------------------------------------------------
Hmargin = 0.1;
Wmargin = 0.1;
if CBAR_flag
    CBARmargin = 0.05;
else
    CBARmargin = 0;
end
Wdelta = Wmargin/(nCOL+1);
Hdelta = Hmargin/(nROW+1);
W = (1-Wmargin-CBARmargin)/nCOL;
H = (1-Hmargin)/nROW;

RECT = simtb_figdimension(nCOL/nROW, .6, 'cm');
arg1 = linspace(-1,1,nV);

F = figure('units', 'pixels', 'Position', RECT, 'MenuBar', 'figure', ...
    'color', [0 0 0], 'DefaultTextColor', 'w', 'DefaultAxesColor', 'k', ...
    'DefaultAxesYColor', 'w', 'DefaultAxesZColor', 'w', 'DefaultPatchFaceColor', 'w', ...
    'DefaultPatchEdgeColor', 'w','DefaultSurfaceEdgeColor', 'w', 'DefaultLineColor', 'k', ...
    'Visible', 'on', 'Name', figname, 'resize', 'on');

for c = 1:nC
    thisrow = ceil(c/nCOL);
    thiscol = mod(c,nCOL);
    if thiscol == 0, thiscol = nCOL; end
    
    HA(c) = subplot('Position', [Wdelta*thiscol + W*(thiscol-1), 1-(Hdelta*thisrow + H*(thisrow)), W,H]);
    SMtemp  = reshape(SM(c,:), nV, nV);
    imagesc(arg1, arg1, SMtemp);
    axis xy; 
    axis square; 
    axis off;
    hold on
    BL = polar(HA(c), linspace(0,2*pi,256),ones(1,256));
    set(BL, 'Color', 'w', 'LineWidth', 1)
    T(c) = title(num2str(c), 'Color', 'w');
end

amax = max(abs(SM(:)));
set(T, 'Position', [0, 0.99,1], 'FontSize', 8)
set(HA, 'CLIM', [-amax, amax])
colormap(CMAP);
%Rui:
set(gcf, 'InvertHardCopy', 'off'); 
%--------------------------------------------------------------------------
% make a large colorbar
%--------------------------------------------------------------------------

if CBAR_flag
    C = colorbar('position', [(W+Wdelta)*nCOL + CBARmargin/6, Hdelta, CBARmargin/5, H*(nROW)+Hdelta*(nROW-1)]);
    set(C, 'YAxisLocation', 'right','FontSize',10,'Color',[1,1,1]);

    ytick = linspace(-amax, amax, 3);
    for ii = 1:length(ytick)
        ytl{ii} = sprintf('%0.3f', ytick(ii));
    end
    set(C, 'YTick', ytick, 'YTickLabel', ytl);
    set(get(C, 'YLabel'), 'FontSize', 8, 'String', 'amplitude')
end
