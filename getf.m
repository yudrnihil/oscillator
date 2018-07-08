function [f]=getf(x,RLC,IVsource)
    R=RLC.R;
    C=RLC.C;
    L=RLC.L;
    Ctail=RLC.Ctail;
    
    Vdd=IVsource(1);
    Ib=IVsource(2);
    
    Ids1=IdMOS(x(3)-x(1),x(2)-x(1));
    Ids2=IdMOS(x(2)-x(1),x(3)-x(1));
    
    f=[1/Ctail*(Ids1+Ids2-Ib);...
        1/C*(x(4)-Ids1-(x(2)-Vdd)/R);... %Single ended R
        1/C*(x(5)-Ids2-(x(3)-Vdd)/R);... %Single ended R
        1/L*(Vdd-x(2));...
        1/L*(Vdd-x(3))];
end