function [ rgbhist_mem, position_mem, colour_indexing ] = Assign_histlabels( rgbhist_mem, position_cur, rhistos,ghistos,bhistos, position_mem)
%ASSIGN_HISTLABELS Summary of this function goes here

% init the struct of histograms
if sum(sum(sum(rgbhist_mem)))==0;
    dims = size(rgbhist_mem);
    for i=1:dims(1);
       rgbhist_mem(i,1,:) = rhistos(i,:);  
       rgbhist_mem(i,2,:) = ghistos(i,:);
       rgbhist_mem(i,3,:) = bhistos(i,:);
    end
    colour_indexing = [1:dims(1)]';
    %----------------------------------------
    dimpos = size(position_cur);
    for i=1:dimpos(1);
       pos = position_cur(i).Centroid;
       position_mem(i,1) = pos(2);
       position_mem(i,2) = pos(1);
    end
else
    % update struct of hists and assign colour indexes
    [ rgbhist_mem, position_mem, colour_indexing ] = Find_best_matchinghist3( rgbhist_mem, position_cur ,rhistos,ghistos,bhistos,position_mem);
 
end

end

