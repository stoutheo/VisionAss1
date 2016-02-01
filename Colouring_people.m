function [ final_im ] = Colouring_people( label, coloumap )
%COLOURING_PEOPLE Summary of this function goes here
%   Detailed explanation goes here

[x,y] = size(label{1});

final_im = zeros(x,y,3);

coloumap
size(label)
for i=1:length(coloumap)

    % white person
    if coloumap(i) == 1
       image = zeros(x,y,3);
       image(:,:,1:2)=127;
       mask = label{i};
       mask3 = cat(3,mask,mask,mask);
       final_im = final_im + image.* mask3;
       
    % red person   
    elseif coloumap(i) == 2
       image = zeros(x,y,3);
       image(:,:,1) = 127;
       mask = label{i};
       mask3 = cat(3,mask,mask,mask);
       final_im = final_im + image.* mask3; 
    
    % green person   
    elseif coloumap(i) == 3   
       image = zeros(x,y,3);
       image(:,:,2) = 127;
       mask = label{i};
       mask3 = cat(3,mask,mask,mask);
       final_im = final_im + image.* mask3;
    
    % blue person   
    elseif coloumap(i) == 4    
       image = zeros(x,y,3);
       image(:,:,3) = 127;
       mask = label{i};
       mask3 = cat(3,mask,mask,mask);
       final_im = final_im + image.* mask3;
    end

end


end

