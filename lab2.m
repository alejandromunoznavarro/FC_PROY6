clear;
clc;

load keypoints;
NF = 12;

for k = 1:NF
    fprintf('imagen %d: ',k);
    [xy1, xy2] = find_matches(s{2}, s{k});
    fprintf('puntos %d\n',size(xy1,1));
end