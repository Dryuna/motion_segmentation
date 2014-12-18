function W = computemultiscalew1 (image_x, image_y,layers,dataW);
% compute multiscale image affinity matrix W from input image, layer
% parameters layers, and affinity matrix parameters dataW
% Timothee Cour, 29-Aug-2006 07:49:15


ns=length(layers);

%compute each scale of multiscale W
for i=1:ns
    Ws{i}=computew_1scale1(image_x, image_y,layers(i),dataW);
end
[p,q,r]=size(image_x);

%hack: for stability, prevents isolated nodes
maxi=max(max(Ws{1}));
Ws{1}=Ws{1}+0.01*maxi*mex_neighborW(p,q,4);

%aggregate each scale of W
W=Ws{1};
Ws{1}=[];
for i=2:ns
    [ni,nj]=size(W);
    [ni2,nj2]=size(Ws{i});
    W=[W,sparse(ni,nj2);sparse(ni2,nj),Ws{i}];
    Ws{i}=[];
end

