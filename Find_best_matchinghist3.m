function [ rgbhist_mem, position_mem, colour_indexing ] = Find_best_matchinghist( rgbhist_mem, position_cur ,rhistos,ghistos,bhistos, position_mem)
%Find_best_matchinghist Assign the labels to teach patch

dims = size(rgbhist_mem);
dimpos = size(position_mem);

rhist_dim = size(rhistos);

colour_indexing = zeros(rhist_dim(1),1);

for regions=1:rhist_dim(1)
    vals = ones(dims(1),1)*1000;
    % compute distance of histograms
    for i=1:dims(1)
        vals(i) = Eval_patch_hist(rgbhist_mem(i,1,:),rgbhist_mem(i,2,:),rgbhist_mem(i,3,:),rhistos(regions,:),ghistos(regions,:),bhistos(regions,:));
    end
    
    %vals
    %x = [vals, valpos]
    %finalvals = vals + valpos/100;
    
    % find index with the smallest distance
    index = find(vals==min(vals));
    
    if length(index)>1
        vals
        index
        index = index(1)
        
    else
        % update the struct of the histograms 
        rgbhist_mem(index,1,:) = rhistos(regions,:);  
        rgbhist_mem(index,2,:) = ghistos(regions,:);
        rgbhist_mem(index,3,:) = bhistos(regions,:);
    end
    % indexs of the colours assigned to each area(patch)
    colour_indexing(regions,1) = index; 
end   

disp('next round ---------------')
d = [1,2,3,4];
while length(unique(colour_indexing)) < 4
      for regions=1:dimpos(1)

          valpos = ones(dimpos(1),1)*1000;
          for k=1:rhist_dim(1)
              valpos(k) = Eval_patch_pos(position_mem(k,:),position_cur(regions,:));
          end
          valpos
      
      va = valpos.* vals;
      index2 = find(va==min(va));
      %usedindex(res(j)) = index2;

      colour_indexing(regions,1) = index2; 

      %min(valpos)
      %distance = Eval_patch_pos(position_mem(res(j),:),position_cur(res(j),:))

      % update the struct of the positions 
      pos = position_cur(regions).Centroid;
      position_mem(regions,1) = pos(2);
      position_mem(regions,2) = pos(1);

      % update the struct of the histograms 
      rgbhist_mem(index2,1,:) = rhistos(regions,:);  
      rgbhist_mem(index2,2,:) = ghistos(regions,:);
      rgbhist_mem(index2,3,:) = bhistos(regions,:);
      end
end
  
colour_indexing

    
end

