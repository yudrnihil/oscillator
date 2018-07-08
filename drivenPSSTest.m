%pss for driven oscillator

%f0=1.59155GHz, Q=5
RLC=struct('R',50,'L',1e-9,'C',1e-11,'Ctail',10e-14);
ttran=1e-8; % initial transient simulation for 10ns
tstep=1e-12;
nstep=ttran/tstep;

%locked
Ib=8e-3+1.6e-3*cos(2*pi*3.17e9*tstep*(1:nstep));

Vdd=ones(1,nstep);
IVsource=[Vdd;Ib];

% run transient
xInitial=[0.1022;1.8657;0.1343;0.02182;-0.01781];
X=tpz(xInitial,tstep,nstep,RLC,IVsource);
xInitial=X(:,nstep); % use initial transient result as pss guess

% pss for driven oscillator
% T determined by injection frequency
X=shooting2(xInitial,6309e-13,1e-12,RLC,IVsource);
plot(1:length(X),X(1:3,:))