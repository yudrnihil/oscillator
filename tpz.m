% trapezoid
function [X]=tpz(xInitial,tstep,nstep,RLC,IVsource)
    X=zeros(5,nstep);
    X(:,1)=xInitial;
    
    errorThreshold=1e-5;
    dV=1e-6;
    dI=1e-7;
    
    for i = 1:nstep-1
        x=X(:,i);
        fx=getf(x,RLC,IVsource(:,i));
        xp=x+fx*tstep;
        fxp=getf(xp,RLC,IVsource(:,i));
        left=xp-0.5*tstep*fxp;
        right=x+0.5*tstep*fx;
        error=left-right;
        while abs(error)>errorThreshold
            left1=(xp+[dV;0;0;0;0])-0.5*tstep*getf(xp+[dV;0;0;0;0],RLC,IVsource(:,i));
            left2=(xp+[0;dV;0;0;0])-0.5*tstep*getf(xp+[0;dV;0;0;0],RLC,IVsource(:,i));
            left3=(xp+[0;0;dV;0;0])-0.5*tstep*getf(xp+[0;0;dV;0;0],RLC,IVsource(:,i));
            left4=(xp+[0;0;0;dI;0])-0.5*tstep*getf(xp+[0;0;0;dI;0],RLC,IVsource(:,i));
            left5=(xp+[0;0;0;0;dI])-0.5*tstep*getf(xp+[dV;0;0;0;dI],RLC,IVsource(:,i));
            J=[(left1-left)/dV (left2-left)/dV (left3-left)/dV (left4-left)/dI (left5-left)/dI];
            
            xp=xp-J\error;
            fxp=getf(xp,RLC,IVsource(:,i));
            left=xp-0.5*tstep*fxp;
            right=x+0.5*tstep*fx;
            error=left-right;
        end
        X(:,i+1)=xp;
    end
end