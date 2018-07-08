% PSS for driven oscillator, where T is determined by injection frequency
function [X] = shooting2(xInitial,T,tstep,RLC,IVsource)
    dV=1e-6;
    dI=1e-7;
    errorthreshold=1e-8;
    nstep=round(T/tstep);
    
    x0=xInitial; 
    [phi0]=tpz(x0,tstep,nstep,RLC,IVsource);
    xT=phi0(:,nstep);
    error=xT-x0;
    errorsq=sum(error.^2)
    
    while errorsq>errorthreshold
        %Jacobian
        [phi1]=tpz(x0+[dV;0;0;0;0],tstep,nstep,RLC,IVsource);
        [phi2]=tpz(x0+[0;dV;0;0;0],tstep,nstep,RLC,IVsource);
        [phi3]=tpz(x0+[0;0;dV;0;0],tstep,nstep,RLC,IVsource);
        [phi4]=tpz(x0+[0;0;0;dI;0],tstep,nstep,RLC,IVsource);
        [phi5]=tpz(x0+[0;0;0;0;dI],tstep,nstep,RLC,IVsource);
        J=[(phi1(:,nstep)-xT)/dV (phi2(:,nstep)-xT)/dV (phi3(:,nstep)-xT)/dV...
            (phi4(:,nstep)-xT)/dI (phi5(:,nstep)-xT)/dI];
        
        % new x0
        left=J-eye(5);
        dx=left\error;
        x0=x0-dx;
        [phi0]=tpz(x0,tstep,nstep,RLC,IVsource);
        xT=phi0(:,nstep);
        % new error
        error=xT-x0;
        errorsq=sum(error.^2)
    end
    X=phi0;
end