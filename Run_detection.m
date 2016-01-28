
path = pwd;
image_path = strcat(path,'/../DATA1/');

backround = 'bgframe.jpg';
% load all images 
[images,backround, clean_images,clean_backround] = Load_images(image_path,backround);

% build the normalised backround image 
[normRGBImback , intesityRGBImback]  = NormaliseRGB_S(clean_backround,0);

for i=1:length(clean_images)
    
    [normRGBIm , intesityRGBIm]  = NormaliseRGB_S(clean_images{i},0);
    [MR,MC,Dim] = size(intesityRGBIm);
    fore = zeros(MR,MC);
    fore = (abs(intesityRGBIm(:,:)-intesityRGBImback(:,:)) > 15);% ...
    foremm = bwmorph(fore,'clean',2);
    foremm = bwmorph(foremm,'close',4);
    
    
    % clear the data
    %sele = Clear_data(foremm,3);
    [sele, information] = Clear_data(foremm,0);

    fig_vis1 = 1;
    
    if fig_vis1 > 0
        figure(fig_vis1)
        clf
        imshow(sele)
    end
    
    pause(0.3)
    
end