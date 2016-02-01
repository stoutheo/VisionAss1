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
    
    %x = [vals, valpos]
    %finalvals = vals + valpos/100;
    
    % find index with the smallest distance
    index = find(vals==min(vals));
    
    % update the struct of the histograms 
    %rgbhist_mem(index,1,:) = rhistos(regions,:);  
    %rgbhist_mem(index,2,:) = ghistos(regions,:);
    %rgbhist_mem(index,3,:) = bhistos(regions,:);
    
    % indexs of the colours assigned to each area(patch)
    colour_indexing(regions,1) = index; 
end   

if length(unique(colour_indexing)) < 4
   for i=1:length(colour_indexing)
       res = find(colour_indexing==colour_indexing(i));
       if length(res)>1
          for j=1:length(res)
              if j==1
                  index2 = 10;
              end
              valpos = ones(dimpos(1),1)*1000;
              for k=1:dimpos(1)
                  valpos(k) = Eval_patch_pos(position_mem(k,:),position_cur(j,:));
                  if k == index2
                     valpos(k) = 1000;
                  end
              end
              valpos
              index2 = find(valpos==min(valpos));
              
              colour_indexing(j,1) = index2; 
              % update the struct of the positions 
              pos = position_cur(j).Centroid;
              position_mem(j,1) = pos(2);
              position_mem(j,2) = pos(1);
          end
       end
   end
end

    
end




