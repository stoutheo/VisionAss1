function [ im ] = Clear_bottom_labellines( image )
%CLEAR_BOTTOM_LABELLINES Clear the lines at the bottom of the image looking
% like labelling 

[MR,MC,Dim] = size(image);
im = image;
for i=1:MR;
    num_zeros = sum(sum(image(i,:,:)==0));
    % if number of black pixels is more than 70% of the line then make line
    % black ... like crop
    if num_zeros>0.7*3*MC;
       im(i,:,:) = 0;
    end
end

end

