
path = pwd;
image_path = strcat(path,'/../DATA1/');

% restriction circles 
global personc1; global pcc2; global personr1; global pcr2;
personc1 = [200,170];
pcc2 = [121, 222];
personr1 = 30;
pcr2 = 3;

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
    
    foren = bwareaopen(fore,30);
    foremm = bwmorph(foren,'dilate',5);
    foremm = bwmorph(foremm,'erode',2);
    
    foremm = bwmorph(foremm,'spur',8);
    %foremm = bwmorph(foremm,'close',3);

    % clear the data
    %returned mask, without static coach and the notebook
    sele = Clear_data_2(foremm,0);
    
    %try using original rgb
    [rhistos,ghistos,bhistos,obj_props] = labeling_people(sele,clean_images{i});
    
    %[sele, information] = Clear_data(foremm,0);
    
    %foremm = bwmorph(sele,'dilate',2);
    %foremm = bwmorph(foremm,'spur',8);
    
    %sele(150:170,180:200) = 1;
    
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
        imshow(sele)
    end
    
    %break
    %pause(0.3)
    
end