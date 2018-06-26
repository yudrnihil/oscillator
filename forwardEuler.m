function [X, Y] = forwardEuler(xInitial, tstep, nstep)
    global V4 LC C A Ib
    % x is a vector x=[V2 V3 dV2dt dV3dt]
    % y is a vector y=[Ids1 Ids2 V1]
    % X is collection of x, Y is collection of y
    X=zeros(4,nstep);
    X(:,1)=xInitial;
    Y=zeros(3,nstep);
    V1=0.2765; %initial guess of V1
    for i=1:nstep-1
        V2N=[1 0 tstep 0]*X(:,i);
        V3N=[0 1 0 tstep]*X(:,i);
        [Ids1,Ids2,V1]=solveV1(X(1,i),X(2,i),Ib(i),V1);
        Y(:,i)=[Ids1 Ids2 V1];
        [Ids1N,Ids2N,V1N]=solveV1(V2N,V3N,Ib(i+1),V1);
        dIds1dt=(Ids1N-Ids1)/tstep;
        dIds2dt=(Ids2N-Ids2)/tstep;
        b=[0; 0; V4/LC-dIds1dt/C; V4/LC-dIds2dt/C];
        RHS=A*X(:,i)+b;
        X(:,i+1)=X(:,i)+RHS*tstep;
    end
    Y(:,nstep)=solveV1(X(1,nstep),X(2,nstep),Ib(nstep),V1);
end
