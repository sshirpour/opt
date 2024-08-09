% -----------------------------------------------------------------------------------------------------------
% Sparrow Search algorithm (SSA) (demo)
% Programmed by Jian-kai Xue    
% Updated 21 Mar, 2020.                     
%
% This is a simple demo version only implemented the basic         
% idea of the SSA for solving the unconstrained problem.    
% The details about SSA are illustratred in the following paper.    
% (To cite this article):                                                
%  Jiankai Xue & Bo Shen (2020) A novel swarm intelligence optimization
% approach: sparrow search algorithm, Systems Science & Control Engineering, 8:1, 22-34, DOI:
% 10.1080/21642583.2019.1708830

%clear all 
%clc
fs=3000;
sig=sig7(1001:4000,1);
SearchAgents_no=10; % Number of search agents

Max_iteration=30; % Maximum numbef of iterations

% Load details of the selected benchmark function
dim=2;
lb=[2 1000];
ub=[10 10000];
tic
%[fMin,bestX,SSA_curve]=SSA(SearchAgents_no,Max_iteration,lb,ub,dim,sig);  

[fMin,bestX,SSA_curve]=TDO(SearchAgents_no,Max_iteration,lb,ub,dim,sig);
toc
%Draw objective space
 semilogy(SSA_curve)
  
title('Objective function')
xlabel('Iteration');
ylabel('Best score obtained so far');
%axis tight
grid on
box on
legend('Entropy')
display(['The best solution obtained by SSA is K= ', num2str(bestX(1)), ' alpha= ', num2str(bestX(2))]);
display(['The best optimal value of the objective funciton found by SSA is : ', num2str(fMin)]);
%%%%%%%%%%%%% Calculating the optimal imfs %%%%%%%%%%%%
imf = vmd(sig,'NumIMFs',bestX(1),'PenaltyFactor', bestX(2),'InitializeMethod','grid','AbsoluteTolerance',10E-7);
U=max(sig)*1.2;
L=min(sig)*1.2;
sp=size(sig);
lenght=sp(1,1);
%%%%%%%% Ploting the original signal %%%%%%%%%%%
figure 
plot(sig);
axis([0, lenght, L, U]);
title('The original signal');
%%%%%%%%%% Ploting the imfs %%%%%%%%%%%%%
for i=1:1:bestX(1)
    figure
    plot(imf(:,i));
    axis([0, lenght, L, U]);
    C = {'IMF',num2str(i)};
    title(strjoin(C));
end

for i=1:1:bestX(1)
    y=fft(imf(:,i));
    L=numel(imf(:,i));
    P2=abs(y/L);
    P1=P2(1:L/2+1);
    P1(2:end-1)=2*P1(2:end-1);
    f=fs*(0:(L/2))/L;
    figure
     plot(f,P1);
    %axis([0, lenght, L, U]);
    xlabel('f (Hz)');
    C = {'IMF',num2str(i)};
    title(strjoin(C));
end

