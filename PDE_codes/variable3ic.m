function u0 = variable3ic(x)
%Defines the initial conditions for the solver. At present, sets 
%bacteria concentration to 1 everywhere, and virus concentration to 1 for 
%x=<2 and 0 elsewhere. 
global tmax;
V0=1; 
B0=1;
u0=zeros(ceil(tmax)*3,1);
for i=1:length(u0)
    if mod(i+2,3)==0
        u0(i)=B0;
    end
    if mod(i,3)==0
        u0(i)=V0;
        if x>2
            u0(i)=0;
        end
    end
end
end