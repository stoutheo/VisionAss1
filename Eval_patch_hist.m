function [ result ] = Eval_patch_hist( oldhist_r,oldhist_g,oldhist_b, hist_r,hist_g,hist_b )
%COMPARE_HIST Compute the distance between two patch in all channels from
%the histogramms

histdim = size(hist_r);
red = bhattacharyya(reshape(oldhist_r(1,1,:),1,histdim(2)),hist_r(1,:));
green = bhattacharyya(reshape(oldhist_g(1,1,:),1,histdim(2)),hist_g(1,:)) ;
blue = bhattacharyya(reshape(oldhist_b(1,1,:),1,histdim(2)),hist_b(1,:)) ;

%red = histogram_chisquare(reshape(oldhist_r(1,1,:),1,histdim(2)),hist_r(1,:));
%green = histogram_chisquare(reshape(oldhist_g(1,1,:),1,histdim(2)),hist_g(1,:)) ;
%blue = histogram_chisquare(reshape(oldhist_b(1,1,:),1,histdim(2)),hist_b(1,:)) ;


result = red+green+blue;
  
end

