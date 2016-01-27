function [ Imwork_images,Imbackround ] = Load_images( pathtofile, bck_name )
%LOAD_IMAGES Summary of this function goes here
%   Detailed explanation goes here

listoffiles = dir(pathtofile); 
image_num = 0;
for i=1:length(listoffiles);
    fname = listoffiles(i).name;
    if ~isempty(strfind(fname,'jpg'));
        image_num = image_num + 1;
    end
end
Imwork_images = cell(image_num-1,1);
length(Imwork_images)
image_path_bck = strcat(pathtofile,bck_name);
Imbackround = imread(image_path_bck);

counter = 1;
for i=1:length(listoffiles);
   fname = listoffiles(i).name;
   if ~isempty(strfind(fname,'jpg'));
       if strcmp(fname, bck_name) == 0;
           image_path = strcat(pathtofile,fname);
           Imwork_images{counter} = imread(image_path);
           counter = counter + 1; 
       end
   end
end



end

