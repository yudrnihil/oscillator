function [dIdVgs, dIdVds] = derivativeIds(Vgs, Vds)
   dV=1e-5;
   Ids=IdMOS(Vgs,Vds);
   dIdVgs=(IdMOS(Vgs+dV,Vds)-Ids)/dV;
   dIdVds=(IdMOS(Vgs,Vds+dV)-Ids)/dV;
end