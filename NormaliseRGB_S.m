function [ normRGBImage, intesityRGBImage ] = NormaliseRGB_S( Im, vis_flag )
%NORMALISERGB_S .. RGB normalise of image and an array of the intesity
%values

% sum of the rgb values for each pixel
RGBt = sum(double(Im),3);
RGBtd = cat(3,RGBt,RGBt,RGBt);
% normalised rgb
normRGBImage = double(Im)./RGBtd;
% normalised intesity
intesityRGBImage = double(RGBt./3); 

% get rid of all the NaN values and replace with 0
normRGBImage(isnan(normRGBImage)) = 0 ;
intesityRGBImage(isnan(intesityRGBImage)) = 0 ;

%  old implementation

%[MR,MC,Dim] = size(Im);

%normRGBImage = zeros(MR,MC,Dim);
%intesityRGBImage = int8(zeros(MR,MC));

%for i=1:MR 
%  for j=1:MC
%      RGB = sum(Im(i,j,:));
%      for k=1:3
%            normRGBImage(i,j,k) = double(Im(i,j,k))/RGB; 
%      end
%      intesityRGBImage(i,j) = int8(RGB/3);          
%  end
%end


% only for verification reasons, comparison between approaches
%Values = 0
%normRGBImage(isnan(normRGBImage)) = 0 ;
%normRGBImaget(isnan(normRGBImaget)) = 0 ;
%isequal(normRGBImage(:,:,1),normRGBImaget(:,:,1))
%isequal(intesityRGBImage,intesityRGBImaget)


if vis_flag > 0
    figure(vis_flag)
    clf
    %imshow(normRGBImback(:,:,:))
    imshow(intesityRGBImage)
end


end

