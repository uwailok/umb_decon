clear all
close all
% clear all
% clc
% load('Rcv_orig_4_degree_1018.mat')

% patch_test = patches()
% for i = 1 : 700
%     rf_data1 = double(abs((dummy(:,:,i))))./sqrt(abs(NoisePowerM));
% end
% load("\\mfad\researchmn\ULTRASOUND\SONG\SHARED\ForUWai\Deconvolution\BloodData20190809T164722_10SVD26_720mat.mat")


load("PD_brain_data.mat")



%% Compute original power Doppler imaging

% PD_brain_data   = rf_data2;
rf_data         = padarray(PD_brain_data,[10 10],'both');
[Nai,Nli,Nt1]   = size(rf_data);




%% Generate PSF 
wsizex  = 101;
wsizez  = 101;
x2      = -floor(wsizex/2):floor(wsizex/2);
z2      = -floor(wsizez/2):floor(wsizez/2);
[X2,Z2] = meshgrid(x2,z2);
mu      = [0,0];
Sigma = [100,0;0,50];
F = mvnpdf([X2(:) Z2(:)],mu,Sigma);
PSF = reshape(F,wsizez,wsizex);
PSF = PSF./max(PSF(:));
PSF_down = PSF(1:5:end,1:10:end);
PSF_down = PSF_down.^2;



%% Normalized and deconvolution %%%%%
rf_data_orig    = rf_data/(max(abs(rf_data(:))));  %%% Normalized the input data

[m,n]   = size(rf_data_orig);

tol     = 1e-10;
max_itr = 30;
mu      = 1/10000;

% Main routine
tic
out = deconvtv_umb(rf_data_orig, PSF_down, mu,max_itr, tol);
toc

output = out;
output = output/max(output(:));
output = abs(output);
output = (output>0).*output;

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







