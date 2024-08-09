function H=fobj(sig,param)
fs=3000; %Hz
K=param(1);
alpha=param(2);
s=size(sig);
N=s(1,1);
[imf,res] = vmd(sig,'NumIMFs',K,'PenaltyFactor', alpha,'InitializeMethod','grid','AbsoluteTolerance',10E-7);

E=zeros(1,K);

for i=1:1:K
    L=fs;
    y=fft(imf(:,i));
    P2 = abs(y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    p=P1./sum(P1);
    E(i)=-sum(p.*log(p))/log(L);
end
H=max(E);
end
