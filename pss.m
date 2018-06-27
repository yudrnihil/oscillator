RLC=struct('R',500,'L',1e-9,'C',1e-11,'Ctail',1e-14);
Ib=4e-3*ones(1,100000);
X=shooting(xInitial,6284e-13,1e-13,RLC,Ib);
plot(1:length(X),X(1:3,:))