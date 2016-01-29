function [ select ] = Clear_data( formimage,fig_vis )
%function [ select, infos ] = Clear_data( formimage,fig_vis )

%CLEAR_DATA Summary of this function goes here
%   Detailed explanation goes here

%new_im = double(formimage);
labeled = bwlabel(formimage,4);
stats = regionprops(labeled,'all');
[N,W] = size(stats);
if N < 1
    return   
end

% do bubble sort (large to small) on regions in case there are more than 1
id = zeros(N);
for i = 1 : N
  id(i) = i;
end
for i = 1 : N-1
  for j = i+1 : N
    if stats(i).Area < stats(j).Area
      tmp = stats(i);
      stats(i) = stats(j);
      stats(j) = tmp;
      tmp = id(i);
      id(i) = id(j);
      id(j) = tmp;
    end
 end
end

% make sure that there is at least 1 big region
if stats(1).Area < 100 
  return
end

% select contours with at least 10% of the area of the biggest contour
%area_limit = stats(1).Area;
indexes = [];
numbering = 1;
for i = 1 : N
    if stats(i).Area > 600
       indexes(numbering) = i; %last_id 
       numbering = numbering + 1;
    elseif stats(i).Area > 400 & stats(i).Solidity > 0.7
       indexes(numbering) = i; %last_id 
       numbering = numbering + 1;
    end
    if stats(i).Area < 200 
       break
    end
end

sel = (labeled==id(1));
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

