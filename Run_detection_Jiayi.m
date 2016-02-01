clear
clc

path = pwd;
image_path = strcat(path,'/../DATA1/');

% restriction circles 
global personc1; global pcc2; global personr1; global pcr2;
personc1 = [200,170];
pcc2 = [121, 222];
personr1 = 30;
pcr2 = 3;
clc
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
    foremm = bwmorph(foren,'dilate',3.5);
    foremm = bwmorph(foremm,'erode',1);
    %foremm = bwmorph(foremm,'spur',8);
    
    %foremm = bwmorph(foren,'dilate',4.5);
    %foremm = bwmorph(foremm,'erode',1);
    %foremm = bwmorph(foremm,'spur',8);
    
    % clear the data
    %returned mask, without static coach and the notebook
    sele = Clear_data_2(foremm,0);
    
    %try using original rgb
    
    %[rhistos,ghistos,bhistos,obj_props,labels] = labeling_people(sele,clean_images{i});
    [rhistos,ghistos,bhistos,obj_props,labels] = labeling_people(sele,normRGBIm);
    %length(obj_props)
    
    if exist('rgbhist_struct','var')==0
        dims_hist = size(rhistos);
        rgbhist_struct = zeros(length(labels),3,dims_hist(2));
        position_struct = zeros(length(obj_props),2);
    end
    
    [rgbhist_struct,position_struct,colour_map] = Assign_histlabels( rgbhist_struct,obj_props, rhistos,ghistos,bhistos, position_struct);
    colour_map
    sele2 = Colouring_people(labels, colour_map );
    
    sele3 = labels{1} + labels{2} + labels{3} +labels{4};
    
    %---------------------------------------------
    fig_vis1 = 1;
    
    %h = labels{1};
    %k = obj_props(1);c
    
    %h(int32(k.Centroid(2)),int32(k.Centroid(1))) = 0;
    
    %s = sele.*foremm2;
    
    if fig_vis1 > 0
        figure(fig_vis1)
        clf
        subplot(1,2,1);
        imshow(sele2)
        subplot(1,2,2);
        imshow(sele3)
    end
    
    %if i == 2
    %    break
    %end
    pause(1)
end
