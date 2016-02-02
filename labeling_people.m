function [rhists,ghists,bhists,obj_props,label]=labeling_people(mask,img_rgb)
%img_rgb can be original rgb image or normalised rgb image

[MR,MC,DIM]=size(img_rgb);

%labeling objects from the mask,initial attemp
attempt_labeling = bwlabel(mask,4);
attempt_labeled = logical(attempt_labeling);
attempt_obj_props = regionprops(attempt_labeled,'all');

full_num_objs = 4;
num_objs = length(attempt_obj_props);

if num_objs==2
    mask = CutObject(attempt_obj_props(1),mask);
    mask = CutObject(attempt_obj_props(2),mask);
    mask = bwmorph(mask,'clean',1);
    mask = bwmorph(mask,'spur',8);
    mask = bwareaopen(mask,30);
elseif num_objs == 3
    biggest_obj_area = 0.0;
    for i = 1:length(attempt_obj_props)
        if attempt_obj_props(i).Area>biggest_obj_area
            biggest_obj_area = attempt_obj_props(i).Area;
            biggest_index = i;
        end
    end
    mask = CutObject(attempt_obj_props(biggest_index),mask);
    mask = bwmorph(mask,'clean',1);
    mask = bwmorph(mask,'spur',8);
    mask = bwareaopen(mask,30);
end

imshow(mask)

%redo everything
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

rhists = zeros(full_num_objs,length(edges));
ghists = zeros(full_num_objs,length(edges));
bhists = zeros(full_num_objs,length(edges));

obj_props_length = length(obj_props);
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
    
    rhists(i,:)=rhist;
    ghists(i,:)=ghist;
    bhists(i,:)=bhist;
    
    %rgbhists = [rhist;ghist;bhist];
    %hists(:,:,i) = rgbhists;
end
