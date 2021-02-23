clear all
close all
load("PD_brain_data.mat")

%% Compute original power Doppler imaging
rf_data         = padarray(PD_brain_data,[10 10],'both');
[Nai,Nli,Nt1]   = size(rf_data);

%% download your point spread function 
load PSF_down 


%% Normalized and deconvolution %%%%%
rf_data_orig    = rf_data/(max(abs(rf_data(:))));  %%% Normalized the input data
[m,n]           = size(rf_data_orig);
tol             = 1e-10;
max_itr         = 30;
mu              = 1/100;

% Main routine
% tic
out = deconvtv_umb(rf_data_orig, PSF_down, mu,max_itr, tol);
% toc

output = out;
output = output/max(abs(output(:)));  %% normalized data
output = (output>0).*output;  %% discard the value smaller than 
output = abs(output);

figure(1);
imagesc(x,z,20*log10(rf_data_orig(10:end-10,10:end-10,:)));
caxis([-60 0])
colormap(hot)
colorbar
set(gca,'FontSize',12);
set(gca,'FontName','Times New Roman');
ylabel('Axial (mm)')
xlabel('Lateral (mm)')
axis image
title('Original PD image')

figure(2);
imagesc(x,z,20*log10(output(10:end-10,10:end-10,:)));
caxis([-60 0])
colormap(hot)
colorbar
set(gca,'FontSize',12);
set(gca,'FontName','Times New Roman');
ylabel('Axial (mm)')
xlabel('Lateral (mm)')
axis image
title('PD image with TV')


