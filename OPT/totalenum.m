% -----------------------------------------------------------------------------------------------------------
% Sparrow Search algorithm (SSA) (demo)
% Programmed by Jian-kai Xue    
% Updated 21 Mar, 2020.                     
%
% This is a simple demo version only implemented the basic         
% idea of the SSA for solving the uncons   trained problem.    
% The details about SSA are illustratred in the following paper.    
% (To cite this article):                                                
%  Jiankai Xue & Bo Shen (2020) A novel swarm intelligence optimization
% approach: sparrow search algorithm, Systems Science & Control Engineering, 8:1, 22-34, DOI:
% 10.1080/21642583.2019.1708830

%clear all 
%clc

% SearchAgents_no=10; % Number of search agents
% 
% Max_iteration=30; % Maximum numbef of iterations
% 
% % Load details of the selected benchmark function
% dim=2;
sig=sig7(1001:4000,1);
lb_K=2;
ub_K=10;
lb_alpha=1000;
ub_alpha=6000;

%Making mesh grid in (K,alpha) space
[K,alpha]=meshgrid(lb_K:1:ub_K,lb_alpha:500:ub_alpha);
[n_K,n_alpha] = size(K');
f=zeros(n_alpha,n_K);
ming=10000;
K_min=0;
alpha_min=0;
tic
for i=1:1:n_alpha
    for j=1:1:n_K
        param=[K(i,j),alpha(i,j)];
        f(i,j)=fobj(sig,param);
        if ( f(i,j)<ming )
            ming=f(i,j);
            K_min=K(i,j);
            alpha_min=alpha(i,j);
        end
    end
end
toc
obj1=surf(K,alpha,f(:,1:n_K));
xlabel("K",'FontSize', 12);
ylabel("$\alpha$",'Interpreter','latex', 'FontSize', 12);
zlabel("Max(E)",'FontSize', 12);
xh = get(gca,'XLabel'); % Handle of the x label
set(xh, 'Units', 'Normalized')
pos = get(xh, 'Position');
set(xh, 'Position',pos.*[0.9,1.3,1],'Rotation',15)
yh = get(gca,'YLabel'); % Handle of the y label
set(yh, 'Units', 'Normalized')
pos = get(yh, 'Position');
set(yh, 'Position',pos.*[0.7,-0.4,1],'Rotation',-26)
  
figure
surface(K,alpha,f(:,1:n_K),'edgecolor', 'none');
shading interp
xlabel("K",'FontSize', 10);
ylabel("$\alpha$",'Interpreter','latex','FontSize', 10);
%zlabel("Average Intensity of Spectra",'FontSize', 10);
colormap(parula(30))

% title('Objective function')
% xlabel('Iteration');
% ylabel('Best score obtained so far');
% %axis tight
% grid on
% box on
% legend('Entropy')
% display(['The best solution obtained by SSA is K= ', num2str(bestX(1)), ' alpha= ', num2str(bestX(2))]);
% display(['The best optimal value of the objective funciton found by SSA is : ', num2str(fMin)]);
% %%%%%%%%%%%%% Calculating the optimal imfs %%%%%%%%%%%%
% imf = vmd(sig1,'NumIMFs',bestX(1),'PenaltyFactor', bestX(2),'InitializeMethod','grid','AbsoluteTolerance',10E-7);
% U=max(sig1)*1.2;
% L=min(sig1)*1.2;
% sp=size(sig1);
% lenght=sp(1,1);
% %%%%%%%% Ploting the original signal %%%%%%%%%%%
% figure 
% plot(sig1);
% axis([0, lenght, L, U]);
% title('The original signal');
% %%%%%%%%%% Ploting the imfs %%%%%%%%%%%%%
% for i=1:1:bestX(1)
%     figure
%     plot(imf(:,i));
%     axis([0, lenght, L, U]);
%     C = {'IMF',num2str(i)};
%     title(strjoin(C));
% end


