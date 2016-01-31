function [rhists,ghists,bhists,obj_props,label]=labeling_people(mask,img_rgb)
%img_rgb can be original rgb image or normalised rgb image

[MR,MC,DIM]=size(img_rgb);

%labeling objects from the mask
labeling = bwlabel(mask,4);
labeled = logical(labeling);

obj_props = regionprops(labeled,'all');

%generate bins edges for historgram
max_val = max(max(max(img_rgb)));

if max_val <= 1.0
    edges = GenerateHistEdges('normalised');
elseif (max_val >1.0) && (max_val<=255.0)
    edges = GenerateHistEdges('origin');
else
    edges = zeros(256,1);
end


for i = 1 : length(obj_props)
    obj = zeros(length(obj_props(i).PixelList),3);
    %img_reshape = reshape(img_rgb,[MR*MC,DIM]);
    for j = 1 : length(obj)
        %inverted pixel index column first and row later
        pix_index = obj_props(i).PixelList(j,:);
        obj(j,:)=img_rgb(pix_index(2),pix_index(1),:);
    end
    objs{i} = obj;
    label{i} = (labeling==i);
    obj_props(i).Mask = label{i};
    
    %calculate variance or mean if needed
    rhist = hist(obj(:,1),edges);
    rhist = rhist/ sum(rhist);
    ghist = hist(obj(:,2),edges);
    ghist = ghist/ sum(ghist);
    bhist = hist(obj(:,3),edges);
    bhist = bhist/ sum(bhist);
    
    rhists{i}=rhist;
    ghists{i}=ghist;
    bhists{i}=bhist;
    
    %rgbhists = [rhist;ghist;bhist];
    %hists(:,:,i) = rgbhists;
end

