%????center???center?????
%line_equa: y = tan(obj_props(1).OriOrientation)x
slope = tan(obj_props(1).Orientation);
center = [obj_props(1).Centroid(2),obj_props(1).Centroid(1)];
for  i = 1:length(obj_props(1).PixelList)
    coord = [obj_props(1).PixelList(i,2),obj_props(1).PixelList(i,1)];
    real_coord = coord-center;
    %sele(coord(1),coord(2))
    if (abs((real_coord(2)-int32(slope*real_coord(1))))==1)||...
            (abs((real_coord(2)-int32(slope*real_coord(1))))==0)
        coord
        sele(coord(1),coord(2)) = 0;
    end
    
end
