function [ rgbhist_mem, colour_indexing ] = Find_best_matchinghist( rgbhist_mem ,rhistos,ghistos,bhistos)
%Find_best_matchinghist Assign the labels to teach patch

dims = size(rgbhist_mem);
colour_indexing = zeros(length(rhistos),1);

for regions=1:length(rhistos)
    vals = ones(dims(1),1)*1000;
    % compute distance of histograms
    for i=1:dims(1)
        vals(i) = Eval_patch_hist(rgbhist_mem(i,1),rgbhist_mem(i,2),rgbhist_mem(i,3),rhistos(regions),ghistos(regions),bhistos(regions));
    end
    % find index with the smallest distance
    index = find(vals==min(vals));
    % update the struct of the histograms 
    rgbhist_mem(index,1) = rhistos(regions);  
    rgbhist_mem(index,2) = ghistos(regions);
    rgbhist_mem(index,3) = bhistos(regions);
    % indexs of the colours assigned to each area(patch)
    colour_indexing(regions) = index; 
end


end
