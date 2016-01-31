function [ result ] = Eval_patch_hist( oldhist_r,oldhist_g,oldhist_b, hist_r,hist_g,hist_b )
%COMPARE_HIST Compute the distance between two patch in all channels from
%the histogramms


red = bhattacharyya(oldhist_r,hist_r);
green = bhattacharyya(oldhist_g,hist_g);
blue = bhattacharyya(oldhist_b,hist_b);

result = sum(red,green,blue);
  
end

