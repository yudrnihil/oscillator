function [A,b]=getMatrix(x,RLC,V4,dIdt)
    [dIdVgsLeft,dIdVdsLeft]=derivativeIds(x(3)-x(1),x(2)-x(1));
    [dIdVgsRight,dIdVdsRight]=derivativeIds(x(2)-x(1),x(3)-x(1));
    
    LC=RLC.L*RLC.C;
    RC=RLC.R*RLC.C;
    C=RLC.C;
    Ctail=RLC.Ctail;
    
    A=[0 0 0 1 0 0;...
        0 0 0 0 1 0;...
        0 0 0 0 0 1;...
        0 0 0 -(dIdVgsLeft+dIdVdsLeft+dIdVgsRight+dIdVdsRight)/Ctail (dIdVdsLeft+dIdVgsRight)/Ctail (dIdVgsLeft+dIdVdsRight)/Ctail;...
        0 -1/LC 0 (dIdVgsLeft+dIdVdsLeft)/C -1/RC-dIdVdsLeft/C 1/RC-dIdVgsLeft/C;...
        0 0 -1/LC (dIdVgsRight+dIdVdsRight)/C 1/RC-dIdVgsRight/C -1/RC-dIdVdsRight/C];
    b=[0;0;0;dIdt/Ctail;V4/LC;V4/LC];
end