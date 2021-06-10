function Jones_Solver(name, Ktemp)
%This is the code that is actually run to solve the pdes for a given K
%value. It should run the solver, and then save the bacteria/virus profiles
%that result in a .mat file. It will then determine the velocity and width
%of the fron by tracking the front, and find the asymptotic velocity based
%on this. These values are then added to the .mat file. In some instances,
%for example if the solver fails prematurely, the velocity determination
%will not work. In this case, the profiles should still be saved, and the
%veolicty can be determined "manually" using a different code.
    global K;
    global Y;
    global tmax;
    Y=50;
    dx=0.1;
    dt=0.1;
    tmax=50;
    Rmax=120;
    
    K=Ktemp;

    % Select Solution Mesh
    x=0:dx:Rmax;
    t=0:dt:tmax;

    %Solve pdes
    m=0;
    sol=pdepe(m,@Jones3,@variable3ic,@variable3bc,x,t);

    %assign bacteria, infected and virus populations
    b=sol(:,:,1);
    i=sol(:,:,2);
    v=sol(:,:,3);
    
    %save solutions of solver incase later stuff fails
    save([name '.mat'],'b', 'i', 'v');

    %pre-assign vectors for velocity and front positions
    p=zeros(1,size(b, 1));
    midB=zeros(1,size(b, 1));
    midI=zeros(1,size(b, 1));
    frontB=zeros(1,size(b, 1));

    %find all of the relavent front positions and work out velcoity and
    %widths
    t0=1;
    for j=1:size(b,1)
        midB(j)=find(b(j,:)>0.5,1);
        if(midB(j)>10 && t0==1) 
            t0=j;
        end
        if(j>t0+2)
            a=polyfit(t(t0:j),midB(t0:j),1);
            p(j)=a(1);
            midI(j)=find((i(j,:)+b(j,:))>0.5,1);
            frontB(j)=find(b(j,:)>0.99,1);
        end
    end
    velocity=zeros(length(p));
    widthB=zeros(length(p));
    widthI=zeros(length(p));
    velocity=p*dx;
    avv=mean(velocity(end-20:end)); 
    widthB=(frontB-midB)*dx*2;
    avw_B=mean(widthB(end-20:end));
    widthI=(midB-midI)*dx;
    avw_I=mean(widthI(end-20:end));   
    
    %Finds asymptotic velocity value
    t_dat=t(200:end);
    v_dat=velocity(200:end);
    fun = @(x)asymptotefcn(x,t_dat,v_dat);
    x0=avv+0.01;
    v_asymptote = fminsearch(fun,x0);
    if v_asymptote>2*avv
        v_asymptote=avv;
    end

    save([name '.mat'],'avv', 'avw_B', 'avw_I', 'b', 'i', 'v', 'K', 'v_asymptote');

end