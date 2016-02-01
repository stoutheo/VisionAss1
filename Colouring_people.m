function [ final_im ] = Colouring_people( label, coloumap )
%COLOURING_PEOPLE Summary of this function goes here
%   Detailed explanation goes here

[x,y] = size(label{1});

final_im = zeros(x,y,3);

coloumap
size(label)
for i=1:length(coloumap)

    % white person
    if i == 1
       image = ones(x,y,3)*255;
       mask = label{coloumap(i)};
       mask3 = cat(3,mask,mask,mask);
       final_im = final_im + image.* mask3;
       
    % red person   
    elseif i == 2
       image = zeros(x,y,3)*255;
       image(:,:,1) = 255;
       mask = label{coloumap(i)};
       mask3 = cat(3,mask,mask,mask);
       final_im = final_im + image.* mask3; 
    
    % green person   
    elseif i == 3   
       image = zeros(x,y,3)*255;
       image(:,:,2) = 255;
       mask = label{coloumap(i)};
       mask3 = cat(3,mask,mask,mask);
       final_im = final_im + image.* mask3;
    
    % blue person   
    elseif i == 4    
       image = zeros(x,y,3)*255;
       image(:,:,3) = 255;
       mask = label{coloumap(i)};
       mask3 = cat(3,mask,mask,mask);
       final_im = final_im + image.* mask3;
    end

end


end
