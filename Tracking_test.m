% subtract background & select pixels with a big difference
path = pwd
image_path_bck = strcat(path,'/../DATA1/bgframe.jpg')
image_path = strcat(path,'/../DATA1/frame137.jpg')
fig_vis = 1;
fig_vis2 = 1;

%Imback = importdata(name,'jpg');
Imback = imread(image_path_bck);
Imwork = imread(image_path);

[normRGBImback , intesityRGBImback]  = NormaliseRGB_S(Imback,0);
[normRGBIm , intesityRGBIm]  = NormaliseRGB_S(Imwork,0);

[MR,MC,Dim] = size(intesityRGBImback);

fore = zeros(MR,MC);
fore = (abs(intesityRGBIm(:,:)-intesityRGBImback(:,:)) > 15);% ...
% | (abs(Imwork(:,:,2) - Imback(:,:,2)) > 10) ...
% | (abs(Imwork(:,:,3) - Imback(:,:,3)) > 10);

foremm = bwmorph(fore,'clean',2);
foremm = bwmorph(foremm,'close',4);

if fig_vis > 0
    figure(fig_vis)
    clf
    imshow(foremm)
end

%%
%foremm = bwmorph(fore,'erode',2);
%foremm = bwmorph(foremm,'close',1);

% erode to remove small noise
%foremm = bwmorph(fore,'spur',1);
%foremm = bwmorph(foremm,'fill',1);
%foremm = bwmorph(foremm,'majority',1);

