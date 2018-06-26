function [Ids1,Ids2,V1] = solveV1(V2, V3, Ib, V1)
% given V2, V3, Ib, initial guess of V1, solve for V1, Ids1, Ids2
% adjust errorThreshold and dV1
    
    errorThreshold=1e-6;
    dV1=1e-4;
    
    Ids1=IdMOS(V3-V1,V2-V1);
    Ids2=IdMOS(V2-V1,V3-V1);
    error=Ids1+Ids2-Ib;

    while abs(error)>errorThreshold
        % derivative
        dFdV1=((IdMOS(V3-V1-dV1,V2-V1-dV1)+IdMOS(V2-V1-dV1,V3-V1-dV1))-(Ids1+Ids2))/dV1;
        % new guess
        V1=V1-dFdV1*error;
        % new error
        Ids1=IdMOS(V3-V1,V2-V1);
        Ids2=IdMOS(V2-V1,V3-V1);
        error=Ids1+Ids2-Ib;
    end
end