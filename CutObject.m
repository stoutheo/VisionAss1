function [mask]=CutObject(obj_prop,label_res)
    %line_equa: y = tan(obj_props(1).OriOrientation)x
    angle_rad = deg2rad(obj_prop.Orientation);
    slope = tan(angle_rad);
    mask = label_res;
    center = [obj_prop.Centroid(2),obj_prop.Centroid(1)];
    for  i = 1:length(obj_prop.PixelList)
        coord = [obj_prop(1).PixelList(i,2),obj_prop(1).PixelList(i,1)];
        local_coord = coord-center;
        %sele(coord(1),coord(2))
        if (abs((local_coord(2)-int32(slope*local_coord(1))))==1)||...
                (abs((local_coord(2)-int32(slope*local_coord(1))))==0)||...
                (abs((local_coord(2)-int32(slope*local_coord(1))))==2)
            mask(coord(1),coord(2)) = 0;
        end
    end
end