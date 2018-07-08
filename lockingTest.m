%f0=1.59155GHz, Q=5
RLC=struct('R',50,'L',1e-9,'C',1e-11,'Ctail',10e-14);
tstop=1e-6;
tstep=1e-12;
nstep=tstop/tstep;

%pulling
%Ib=8e-3+1.6e-3*cos(2*pi*3.13e9*tstep*(1:nstep));
%pulling
%Ib=8e-3+1.6e-3*cos(2*pi*3.15e9*tstep*(1:nstep));
%locked
%Ib=8e-3+1.6e-3*cos(2*pi*3.17e9*tstep*(1:nstep));
%free running
Ib=8e-3*ones(1,nstep);

Vdd=ones(1,nstep);
IVsource=[Vdd;Ib];

% run transient
xInitial=[0.1022;1.8657;0.1343;0.02182;-0.01781];
X=tpz(xInitial,tstep,nstep,RLC,IVsource);
plot(0:tstep:(nstep-1)*tstep,X(1:3,:))
xlabel('Time (s)')
ylabel('Voltage (V)')

% plot PSD
window=kaiser(nstep,20).';
figure(2)
f2=(abs(fft(X(2,:).*window))/1e7).^2;
fs=1/tstep;
df=fs/nstep;
f=0:df:fs-df;
flo=1.5e9;
fhi=1.7e9;
n1=floor(flo/df);
n2=floor(fhi/df);
plot(f(n1:n2),10*log10(f2(n1:n2)/max(f2(n1:n2))))
xlabel('Frequency (Hz)')
ylabel('Power (dB)')