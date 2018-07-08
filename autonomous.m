% PSS for autonomous oscillator, where period T is also an unknown

% Reference T. J. Aprille, Jr. and T. N. Trick, ¡°A computer
% algorithm to determine the steady-state response of
% nonlinear oscillators,¡± IEEE Trans. Circuit Theory, vol.
% CT19, pp. 354-360, July 1972.
% https://ieeexplore.ieee.org/document/1083500/
function [X,T] = autonomous(xInitial,TInitial,tstep,RLC,IVsource)
    dV=1e-6;
    dI=1e-7;
    errorthreshold=1e-8;
    T=TInitial;
    nstep=round(T/tstep);
    
    x0=xInitial; 
    [phi0]=tpz(x0,tstep,nstep,RLC,IVsource);
    xT=phi0(:,nstep);
    error=xT-x0;
    errorsq=sum(error.^2)
    
    while errorsq>errorthreshold
        [phi1]=tpz(x0+[dV;0;0;0;0],tstep,nstep,RLC,IVsource);
        [phi2]=tpz(x0+[0;dV;0;0;0],tstep,nstep,RLC,IVsource);
        [phi3]=tpz(x0+[0;0;dV;0;0],tstep,nstep,RLC,IVsource);
        [phi4]=tpz(x0+[0;0;0;dI;0],tstep,nstep,RLC,IVsource);
        [phi5]=tpz(x0+[0;0;0;0;dI],tstep,nstep,RLC,IVsource);
        
        fxT=getf(xT,RLC,IVsource(:,nstep));
        [~,k]=max(abs(fxT));
        B=[(phi1(:,nstep)-xT)/dV (phi2(:,nstep)-xT)/dV (phi3(:,nstep)-xT)/dV...
            (phi4(:,nstep)-xT)/dI (phi5(:,nstep)-xT)/dI]-eye(5);
        B(:,k)=fxT;
        v=x0;
        v(k)=T;
        v=v-B\error;
        
        if v(k)<=0
            B=[(phi1(:,nstep)-xT)/dV (phi2(:,nstep)-xT)/dV (phi3(:,nstep)-xT)/dV...
            (phi4(:,nstep)-xT)/dI (phi5(:,nstep)-xT)/dI]-eye(5);
            x0=x0-B\error;
        else
            x0=[v(1:k-1);x0(k);v(k+1:5)];
            T=v(k);
        end
        nstep=round(T/tstep);
        [phi0]=tpz(x0,tstep,nstep,RLC,IVsource);
        xT=phi0(:,nstep);
        error=xT-x0;
        errorsq=sum(error.^2)
    end
    X=phi0;
end