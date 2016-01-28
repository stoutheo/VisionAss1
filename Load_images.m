function [ Imwork_images,Imbackround,clean_Imwork_images,clean_Imbackround ] = Load_images( pathtofile, bck_name )
%LOAD_IMAGES According to the path and the name of the backround image 
% the function retrives all images and returns them in list like function

% retrive content of foldr
listoffiles = dir(pathtofile); 
image_num = 0;
% count number of images
for i=1:length(listoffiles);
    fname = listoffiles(i).name;
    if ~isempty(strfind(fname,'jpg'));
        image_num = image_num + 1;
    end
end
% init variables
Imwork_images = cell(image_num-1,1);
clean_Imwork_images = cell(image_num-1,1);
image_path_bck = strcat(pathtofile,bck_name);
Imbackround = imread(image_path_bck);

% clear non-image info 
clean_Imbackround = Clear_bottom_labellines(Imbackround);

% retrieve one by one all the appropriate images
% and add them to the list like struct (cell)
counter = 1;
for i=1:length(listoffiles);
   fname = listoffiles(i).name;
   if ~isempty(strfind(fname,'jpg'));
       if strcmp(fname, bck_name) == 0;
           image_path = strcat(pathtofile,fname);
           temp_image = imread(image_path);
           Imwork_images{counter} = temp_image ;
           clean_Imwork_images{counter} = Clear_bottom_labellines(temp_image);
           counter = counter + 1; 
       end
   end
end


end

