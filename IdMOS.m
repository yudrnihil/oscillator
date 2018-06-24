function [ Ids ] = IdMOS( Vgs, Vds )
%  Calculate Ids given Vgs and Vds
%  https://www.mathworks.com/help/physmod/elec/ref/spicenmos.html
%  Vt: kt/q
%  Vth: threshold
%  K: 1/2*u*Cox*W/L
    Vt=25.9e-3;
    Vth=0.5;
    %K=0.02;
    K=0.1;
    
    %{
    if Vgs > Vth+Vt
        if Vds < Vgs-Vth
            Ids = K*(Vgs-Vth-0.5*Vds)*Vds;
        else 
            Ids = 0.5*K*(Vgs-Vth)^2;
        end
    else
        if Vds < Vt
            Ids = K*(Vt-0.5*Vds)*Vds*exp((Vgs-(Vth+Vt))/Vt);
        else
            Ids = K*(Vt-0.5*Vt)*Vt*exp((Vgs-(Vth+Vt))/Vt);
        end
    end
    %}
    
    Ids=K*(max(Vgs,Vth+Vt)-Vth-0.5*min(Vds,max(Vgs,Vth+Vt)-Vth))*min(Vds,max(Vgs,Vth+Vt)-Vth)...
        *min(1,exp((Vgs-(Vth+Vt))/Vt));
end

