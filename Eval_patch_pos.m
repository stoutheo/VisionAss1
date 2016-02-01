function [ result ] = Eval_patch_pos( position_cur,position_m )
%COMPARE_HIST Compute the distance between two patch in all channels from
%the histogramms

%size(position_cur)
%size(position_m(1).Centroid)
p = position_m(1).Centroid;
result = norm(position_cur(1,:) - [p(2),p(1)]);
  
end

