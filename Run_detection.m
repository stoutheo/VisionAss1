
path = pwd;
image_path = strcat(path,'/../DATA1/');

backround = 'bgframe.jpg';
% load all images 
[images,backround] = Load_images(image_path,backround);
length(images)
% build the normalised backround image 
[normRGBImback , intesityRGBImback]  = NormaliseRGB_S(backround,0);


for i=1:length(images)
    
    [normRGBIm , intesityRGBIm]  = NormaliseRGB_S(images{i},0);
    [MR,MC,Dim] = size(intesityRGBIm);
    size(intesityRGBImback)
    size(normRGBIm)
    fore = zeros(MR,MC);
    fore = (abs(intesityRGBIm(:,:)-intesityRGBImback(:,:)) > 15);% ...
    foremm = bwmorph(fore,'clean',2);
    foremm = bwmorph(foremm,'close',4);
    
    fig_vis = 1;
    
    if fig_vis > 0
        figure(fig_vis)
        clf
        imshow(foremm)
    end
    
end