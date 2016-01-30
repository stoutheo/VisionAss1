
path = pwd;
image_path = strcat(path,'/../DATA1/');

backround = 'bgframe.jpg';
% load all images 
[images,backround, clean_images,clean_backround] = Load_images(image_path,backround);

% build the normalised backround image 
[normRGBImback , intesityRGBImback]  = NormaliseRGB_S(clean_backround,0);

[MC,MR,DIM]=size(backround);

foremms = zeros(MR,MC,2);



%for i=1:length(clean_images)
for i = 1:2
    
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
    
    
    %labeling and detection
    labeled = bwlabel(foremm,4);
    %get pixel indexes
    index = regionprops(labeled,['PixelIdxList']);
    
    flatt_img = reshape(clean_images{i},[MR*MC,3]);
    
    for j = 1 : length(index)
        obj=zeros(length(index(j).PixelIdxList),DIM);
        for k = 1:length(index(j).PixelIdxList)
            obj(k,:)= flatt_img(index(j).PixelIdxList(k),:);
        end
        rhistogram = hist(obj(:,1),255);
        rhistogram = rhistogram/sum(rhistogram);
        ghistogram = hist(obj(:,2),255);
        ghistogram = ghistogram/sum(ghistogram);
        bhistogram = hist(obj(:,3),255);
        bhistogram = bhistogram/sum(bhistogram);
        objs{j}=obj;
        rh{i}=rhistogram;
        gh{i}=ghistogram;
        bh{i}=bhistogram;
        
        test = bhattacharyya(rhistogram,rhistogram)
        
    end
    
    
    
    
    
    %[r1, g1, b1] = rgbhist(reshape(objs{1},[],[],3),0,1);
    
    
    
    %[N,W] = size(stats);
    
    %for i = 1:N
    %    id(i) = i;
    %end
    
    %for i = 1:N
    %    for j = i+1:N
    %        if stats(i).Area<stats(j).Area
    %            temp = stats(i);
    %            stats(i) = stats(j);
    %            stats(j) = temp;
    %            temp = id(i);
    %            id(i) = id(j);
    %            id(j) = temp;
    %        end
    %    end
    %end
    
    %centroid = stats(1).Centroid;
    %radius = sqrt(stats(1).Area/pi);
    
    
    
    % fore2 = (abs(normRGBIm(:,:,1)./normRGBImback(:,:,1)) > 1.2) ...
    % |  (abs(normRGBIm(:,:,2)./normRGBImback(:,:,2)) > 1.2) ...
    % | (abs(normRGBIm(:,:,3)./normRGBImback(:,:,3)) > 1.2 );    
    % foremm2 = bwmorph(fore2,'clean',2);
    % foremm2 = bwmorph(foremm2,'close',8);
    
    fig_vis1 = 0;
    
    %s = sele.*foremm2;
    
    %if fig_vis1 > 0
    %    figure(fig_vis1)
    %    clf
    %    imshow(foremm)
    %    hold on
    %    viscircles(centroid,radius);%cirlce drew but unkown reason for invisible
    %    hold off
        
    %end
    
    %break
    %pause(0.3)
    
end
