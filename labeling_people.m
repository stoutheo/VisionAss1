function [rhists,ghists,bhists,obj_props,label]=labeling_people(mask,img_rgb)
%img_rgb can be original rgb image or normalised rgb image

[MR,MC,DIM]=size(img_rgb);

%labeling objects from the mask
labeling = bwlabel(mask,4);
labeled = logical(labeling);

obj_props = regionprops(labeled,'all');

full_num_objs = 4;
num_objs = length(obj_props);

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

if num_objs==2
    obj_props(3)=obj_props(1);
    %label{3} = (labeling==1);
    obj_props(4)=obj_props(2);
    %label{4} = (labeling==2);
elseif num_objs == 3
    biggest_obj_area = 0.0;
    for i = 1:length(obj_props)
        if obj_props(i).Area>biggest_obj_area
            biggest_obj_area = obj_props(i).Area;
            biggest_index = i;
        end
    end
    obj_props(4) = obj_props(biggest_index);
    %label{4} = (labeling==biggest_index);
end

%length(obj_props)
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

if num_objs == 2
    label{3} = (labeling==1);
    obj_props(3).Mask = label{3};
    label{4} = (labeling==2);
    obj_props(4).Mask = label{4};
elseif num_objs == 3
    label{4} = (labeling==biggest_index);
    obj_props(4).Mask = label{4};
end
end
