function [ normRGBImage, intesityRGBImage ] = NormaliseRGB_S( Im, vis_flag )
%NORMALISERGB_S Summary of this function goes here
%   Detailed explanation goes here

[MR,MC,Dim] = size(Im);

normRGBImage = zeros(MR,MC,Dim);
intesityRGBImage = int8(zeros(MR,MC));
for i=1:MR 
  for j=1:MC
      RGB = sum(Im(i,j,:));
      for k=1:3
            normRGBImage(i,j,k) = double(Im(i,j,k))/RGB; 
      end
      intesityRGBImage(i,j) = int8(RGB/3);          
  end
end

if vis_flag > 0
    figure(vis_flag)
    clf
    %imshow(normRGBImback(:,:,:))
    imshow(intesityRGBImage)
end


end

