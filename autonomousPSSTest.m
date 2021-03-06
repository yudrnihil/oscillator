%pss for autonomous oscillator

%f0=1.59155GHz, Q=5
RLC=struct('R',50,'L',1e-9,'C',1e-11,'Ctail',10e-14);
ttran=2e-9; % initial transient simulation for 10ns
tstep=1e-13;
nstep=ttran/tstep;

%free running
Ib=8e-3*ones(1,nstep);

Vdd=ones(1,nstep);
IVsource=[Vdd;Ib];

% run transient
xInitial=[0.1022;1.8657;0.1343;0.02182;-0.01781];
X=tpz(xInitial,tstep,nstep,RLC,IVsource);
xInitial=X(:,nstep); % use initial transient result as pss guess

% pss for autonomous oscillator
% T is also an unknown
close all
[X,T]=autonomous(xInitial,5500e-13,tstep,RLC,IVsource);
%plot((1:length(X))*tstep,X(1:3,:))
T