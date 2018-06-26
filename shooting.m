function [X] = shooting(xInitial,T,tstep)
    dV=1e-6;
    ddVdt=1e6;
    scale=[1 0 0 0; 0 1 0 0; 0 0 T/(2*pi) 0; 0 0 0 T/(2*pi)];
    scaleInv=[1 0 0 0; 0 1 0 0; 0 0 2*pi/T 0; 0 0 0 2*pi/T];
    errorthreshold=[1e-4;1e-4;1e7;1e7];
    nstep=T/tstep;
    x0=xInitial;
    y0=scale*x0;    
    [phi0,~]=forwardEuler(x0,tstep,nstep);
    xT=phi0(:,nstep);
    yT=scale*xT;
    error=yT-y0
    
    while sum(abs(error)<errorthreshold)<4
        [phi1,~]=forwardEuler(x0+[dV;0;0;0],tstep,nstep);
        [phi2,~]=forwardEuler(x0+[0;dV;0;0],tstep,nstep);
        [phi3,~]=forwardEuler(x0+[0;0;ddVdt;0],tstep,nstep);
        [phi4,~]=forwardEuler(x0+[0;0;0;ddVdt],tstep,nstep);
        J=scale*[(phi1(:,nstep)-xT)/dV (phi2(:,nstep)-xT)/dV ...
            (phi3(:,nstep)-xT)/ddVdt (phi4(:,nstep)-xT)/ddVdt]
        
        lhs=J-scale
        dx=lhs\error
        x0=x0-(J-scale)\error
        y0=scale*x0;
        [phi0,~]=forwardEuler(x0,tstep,nstep);
        xT=phi0(:,nstep);
        yT=scale*xT;
        error=yT-y0;
    end
    X=phi0;
end