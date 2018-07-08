RLC=struct('R',250,'L',1e-9,'C',1e-11,'Ctail',10e-14);
%Ib=8e-3+1.6e-3*cos(2*pi*3.2e9*1e-13*(1:1000000));
Vdd=ones(1,1000000);
Ib=4e-3*ones(1,1000000);
IVsource=[Vdd;Ib];
%xInitial=[0.1022;1.8657;0.1343;-1.4713e9;1.8353e9;-1.8352e9];
%X=forwardEuler2(xInitial,1e-13,1e5,RLC,Ib);

%xInitial=[0.1022;1.8657;0.1343;0.02182;-0.01781];
%X=forwardEuler3(xInitial,1e-13,1e5,RLC,Ib);
%plot(1:100000,X(1:3,:))

%xInitial=[0.1022;1.8657;0.1343;0.02182;-0.01781];
%X=FE('getf',xInitial,1e-13,1e5,RLC,IVsource);
%plot(1:100000,X(1:3,:))

xInitial=[0.1022;1.8657;0.1343;0.02182;-0.01781];
X=tpz(xInitial,1e-12,1e6,RLC,IVsource);
plot(1:1000000,X(1:3,:))

figure(2)
f2=abs(fftshift(fft(X(2,:))))/1e6;
f=-5e12:1e7:5e12-1e7;
plot(f,f2)

%effect of Ctail on convergence