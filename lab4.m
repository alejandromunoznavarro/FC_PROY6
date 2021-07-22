clear;
clc;

load data_ransac


T=get_proy(xy1,xy2)
err=error_ajuste(T,xy1,xy2);
plot(err)
[T Nok]=ransac(xy1,xy2)
err=error_ajuste(T,xy1,xy2);
plot(err)