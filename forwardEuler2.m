function [X] = forwardEuler2(xInitial, tstep, nstep, RLC,Ib)
    X=zeros(6,nstep);
    X(:,1)=xInitial;
    for i = 1:nstep-1
        [A,b]=getMatrix(X(:,i),RLC,1,(Ib(i+1)-Ib(i))/tstep);
        X(:,i+1)=X(:,i)+(A*X(:,i)+b)*tstep;
    end
end