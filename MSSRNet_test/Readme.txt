
***********************************************************************************************************
***********************************************************************************************************

Matlab demo code for "Single Image Super-resolution with Dilated Convolution based Multi-scale Information Learning Inception Module" (submit to ICIP2017) 

by Wuzhen Shi (wzhshi@hit.edu.cn)

If you use/adapt our code in your work (either as a stand-alone tool or as a component of any algorithm),
you need to appropriately cite our ICIP2017 paper.

This code is for academic purpose only. Not for commercial/industrial activities.


***********************************************************************************************************
***********************************************************************************************************


Usage:

install the matconvnet package, please refer to http://www.vlfeat.org/matconvnet/install/ for the detail installation instructions

function:

test_MSSRNets.m - realize super resolution given the model parameters

Folders:

testdata - test images Set5

model -  "MSSRNet_x2.mat" "MSSRNet_x3.mat" and "MSSRNet_x4.mat" are model parameters used for upscaling factors 2,3 and 4 seperately.
