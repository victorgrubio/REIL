clear clc all;
Nb=2;                          % number of bandits
m=[10 30]';
[mmax, im]=max(m);
N_steps=100;
r=[0.1 0];                           % e-greedy values
rew=randn(Nb,N_steps)+kron(m,ones(1,N_steps));
u=ones(1,N_steps);
u([25 50 75])=[0.05 0.05 0.05];

win=zeros(length(r),N_steps);
for kk=1:length(r)
    q=zeros(N_steps,Nb);
    N=zeros(1,Nb);      % Number of times we visited every state
    in_ma=1;
    win(kk,1)=rew(in_ma,1);
    N(1,in_ma)=N(1,in_ma)+1;
    ind=N(1,in_ma);
    q(1,in_ma)=win(kk,1);
    for k=2:N_steps      
        q(k,:)=q(k-1,:);
        %conditional todo
        if  u(k)<r(kk)
            in_ma = 3 - in_ma;
        else
            [ma, in_ma] = max(q(k,:));
        end
        % 3 next todo
        N(1,in_ma)= N(1,in_ma)+1;
        ind = N(1,in_ma);
        win(kk,k) = rew(in_ma,k);  
        q(k,in_ma)=(ind-1)/ind*q(k,in_ma)+1/ind*(win(kk,k));
    end
end
plot(1:N_steps,cumsum(win(1,:)),'b','LineWidth',3),grid,hold
plot(1:N_steps,cumsum(win(2,:)),'r','LineWidth',3),
plot(1:N_steps,(1:N_steps)*max(m),'m','LineWidth',3),hold off
legend('Deterministic exploration','No exploration','Maximum Gain'),
xlabel('Steps')
ylabel('Winnings')
title('Analysis of the Multiarmed Bandit')





