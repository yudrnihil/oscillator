function [X] = shooting(xInitial,T,tstep,RLC,Ib)
    dV=1e-6;
    ddVdt=1e6;
    scale=[1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0;...
        0 0 0 T/(2*pi) 0 0; 0 0 0 0 T/(2*pi) 0; 0 0 0 0 0 T/(2*pi)];
    errorthreshold=[2e-4;2e-4;2e-4;1e-4;1e-4;1e-4];
    nstep=T/tstep;
    
    x0=xInitial; 
    [phi0]=forwardEuler2(x0,tstep,nstep,RLC,Ib);
    xT=phi0(:,nstep);
    error=scale*(xT-x0);
    
    while sum(abs(error)<errorthreshold)<6
        %Jacobian
        [phi1]=forwardEuler2(x0+[dV;0;0;0;0;0],tstep,nstep,RLC,Ib);
        [phi2]=forwardEuler2(x0+[0;dV;0;0;0;0],tstep,nstep,RLC,Ib);
        [phi3]=forwardEuler2(x0+[0;0;dV;0;0;0],tstep,nstep,RLC,Ib);
        [phi4]=forwardEuler2(x0+[0;0;0;ddVdt;0;0],tstep,nstep,RLC,Ib);
        [phi5]=forwardEuler2(x0+[0;0;0;0;ddVdt;0],tstep,nstep,RLC,Ib);
        [phi6]=forwardEuler2(x0+[0;0;0;0;0;ddVdt],tstep,nstep,RLC,Ib);
        J=[(phi1(:,nstep)-xT)/dV (phi2(:,nstep)-xT)/dV (phi3(:,nstep)-xT)/dV...
            (phi4(:,nstep)-xT)/ddVdt (phi5(:,nstep)-xT)/ddVdt (phi6(:,nstep)-xT)/ddVdt];
        
        % new x0
        x0=x0-(scale*(J-eye(6)))\error;
        [phi0]=forwardEuler2(x0,tstep,nstep,RLC,Ib);
        xT=phi0(:,nstep);
        % new error
        error=scale*(xT-x0);
    end
    X=phi0;
end