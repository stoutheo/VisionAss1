function [ rgbhist_mem, colour_indexing ] = Assign_histlabels( rgbhist_mem, rhistos,ghistos,bhistos)
%ASSIGN_HISTLABELS Summary of this function goes here

% init the struct of histograms
if sum(sum(rgbhist_mem))==0; 
    dims = size(rgbhist_mem);
    for i=1:dims(1);
       rgbhist_mem(i,1) = rhistos(i);  
       rgbhist_mem(i,2) = ghistos(i);
       rgbhist_mem(i,3) = bhistos(i);
    end
    colour_indexing = [1:dims(1)];
end

% update struct of hists and assign colour indexes
[ rgbhist_mem, colour_indexing ] = Find_best_matchinghist( rgbhist_mem ,rhistos,ghistos,bhistos);


end

