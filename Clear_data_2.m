function [ select ] = Clear_data_2( formimage,fig_vis )

global personc1; global pcc2; global personr1; global pcr2;

%CLEAR_DATA Summary of this function goes here
%   Detailed explanation goes here

%new_im = double(formimage);
labeled = bwlabel(formimage,4);
stats = regionprops(labeled,'all');
[N,W] = size(stats);
if N < 1
    return   
end

id = zeros(N);
for i = 1 : N
  id(i) = i;
end

% select contours with at least 10% of the area of the biggest contour
indexes = [];
numbering = 1;
for i = 1 : N
    
    % build circle 
    c1 = stats(i).Centroid;
    r1 = stats(i).EquivDiameter/2;
    
    % check for intersection 
    %if ~Circle_intersect(personc1,personr1,c1,r1) 
    if Circle_intersect(pcc2,pcr2,c1,r1) == 0 && Circle_intersect(personc1,personr1,c1,r1) == 0
       indexes(numbering) = i; %last_id 
       numbering = numbering + 1;
    end
    
end    
   

sel = 0;
%pixels_of_inter = cell(last_id,1);
%Centroids = cell(last_id,1);
%diams = cell(last_id,1);
%pixels_of_inter{1} = stats(1).PixelList ;
%Centroids{1} = stats(1).Centroid;
%diams{1} = stats(1).EquivDiameter;
for i = 1 : length(indexes);
    sel = sel | (labeled==id(indexes(i)));
    %pixels_of_inter{i} = stats(i).PixelList;
    %Centroids{i} = stats(i).Centroid;
    %diams{i} = stats(i).EquivDiameter;
end

%infos = {pixels_of_inter,Centroids,diams};

select = (sel);


% visualise 
if fig_vis > 0
    figure(fig_vis)
    clf
    imshow(select)
end

end

