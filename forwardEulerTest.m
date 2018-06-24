global V4 LC Ib C A
L=1e-9;
C=1e-11;
LC=L*C;
R=500;
RC=R*C;
Ib=4e-3;
V4=1;

A=[0 0 1 0;0 0 0 1; -1/LC 0 -1/RC 1/RC;0 -1/LC 1/RC -1/RC];
[result, Y]=forwardEuler([1.1 0.9 9e9 -9e9],1e-12,10000);
plot(1:10000,result(1,:),1:10000,result(2,:))
figure(2)
plot(1:10000,Y(3,:))
figure(3)
plot(1:10000,Y(1:2,:))