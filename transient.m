RLC=struct('R',500,'L',1e-9,'C',1e-11,'Ctail',1e-14);
%Ib=4e-3+8e-4*cos(2*pi*3e9*1e-13*(1:100000));
Ib=4e-3*ones(1,100000);
xInitial=[0.1022;1.8657;0.1343;-1.4713e9;1.8353e9;-1.8352e9];
X=forwardEuler2(xInitial,1e-13,1e5,RLC,Ib);
plot(1:100000,X(1:3,:))