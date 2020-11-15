1. Power Doppler data and the corresponding parameters are stored in "PD_brain_data.mat"

2. Run the MATLAB code "Chicken_embryo_brain_PD.m"

3. The parameters for the input of deconvtv_umb.p as follows:

Function detaol of deconvtv_umb(rf_data_orig, PSF_down,mu,max_itr, tol)

Input:      

1. rf_data_orig : the input power Doppler image
2. PSF_down     : the input 2D point spread function 
3. mu           : regularization parameter
4. max_itr      : maximum number of iterations (default : 100)
5. tol          : tolerance level for the stopping criteria 

Output:

the output deconvolution power Doppler image


