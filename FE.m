% forward euler
function [X] = FE(fx,xInitial,tstep, nstep,p,u)
    X=zeros(length(xInitial),nstep);
    X(:,1)=xInitial;
    for i = 1:nstep-1
        f=feval(fx,X(:,i),p,u(:,i));
        X(:,i+1)=X(:,i)+f*tstep;
    end
end