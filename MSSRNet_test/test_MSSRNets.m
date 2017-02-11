clear all; close all;
addpath('.\utilities');
run ('D:\Program Files\MATLAB\matconvnet-1.0-beta23\matconvnet-1.0-beta23\matlab\vl_setupnn.m')% please change this line with your matconvnet path
net = load('.\model\MSSRNet_x2.mat'); % for upscaling factors 2
net = dagnn.DagNN.loadobj(net.net);
 
showResult  = 0;
useGPU      = 0;
pauseTime   = 0;
scale = 2; % for upscaling factors 2

folderTest = '.\testdata\Set5';
filepaths = dir(fullfile(folderTest,'*.bmp'));

PSNRs = zeros(1,length(filepaths));
SSIMs = zeros(1,length(filepaths));
for i = 1:length(filepaths)
    image = imread(fullfile(folderTest,filepaths(i).name));
    if size(image,3)==3
    image = rgb2ycbcr(image);
    image = modcrop(image,scale);
    image = im2single(image(:, :, 1));
    
    O_Img = image;
    else
        image = modcrop(image,scale);
        image =im2single(image);
        O_Img = image;
    end
    [imh,imw] = size(image);
    input = imresize(imresize(image,1/scale,'bicubic'),[imh,imw],'bicubic');
    
    label = image - input;
    net.eval({'input',input});
    output = net.vars(end-2).value;
    output = output + input;

    output = shave_x3(output, [scale, scale]);
    O_Img = shave_x3(O_Img, [scale, scale]);
    [PSNRCur, SSIMCur] = Cal_PSNRSSIM(im2uint8(output),im2uint8(O_Img),0,0);
   if showResult
        imshow(cat(2,im2uint8(O_Img),im2uint8(input),im2uint8(output)));
        title([filepaths(i).name,'    ',num2str(PSNRCur,'%2.2f'),'dB','    ',num2str(SSIMCur,'%2.4f')])
        drawnow;
        pause(pauseTime)
    end    
    
    PSNRs(i) = PSNRCur;
    SSIMs(i) = SSIMCur; 

end
disp([mean(PSNRs),mean(SSIMs)]);
