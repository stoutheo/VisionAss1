
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
    fore = (abs(intesityRGBIm(:,:)-intesityRGBImback(:,:)) > 15); % ...
    
    foremm = bwmorph(fore,'dilate',5);
    foremm = bwmorph(foremm,'erode',3);
    %foremm = bwmorph(foremm,'spur',2);
    %foremm = bwmorph(foremm,'close',3);

    

    
    
    % clear the data
    sele = Clear_data(foremm,0);
    %[sele, information] = Clear_data(foremm,0);
    
    foremm = bwmorph(sele,'dilate',2);
    foremm = bwmorph(foremm,'spur',4);
    
    
    % fore2 = (abs(normRGBIm(:,:,1)./normRGBImback(:,:,1)) > 1.2) ...
    % |  (abs(normRGBIm(:,:,2)./normRGBImback(:,:,2)) > 1.2) ...
    % | (abs(normRGBIm(:,:,3)./normRGBImback(:,:,3)) > 1.2 );    
    % foremm2 = bwmorph(fore2,'clean',2);
    % foremm2 = bwmorph(foremm2,'close',8);
    
    fig_vis1 = 1;
    
    %s = sele.*foremm2;
    
    if fig_vis1 > 0
        figure(fig_vis1)
        clf
        imshow(foremm)
    end
    
    %break
    %pause(0.3)
    
end