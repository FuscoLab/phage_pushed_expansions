function [pl,ql,pr,qr] = variable3bc(xl,ul,xr,ur,t)
%Defines the Neumann boundary conditions for the solver. 
global tmax;
pl=zeros(ceil(tmax)*3,1);
ql=ones(ceil(tmax)*3,1);
pr=zeros(ceil(tmax)*3,1);
qr=ones(ceil(tmax)*3,1);
end