function [v, q]=policy_evaluation(gamma,N_states,N_actions,N_steps,P,R,pi_m)
% Policy evaluation. V / Q functions
v_ini=zeros(N_states,1);
q_ini=zeros(N_states*N_actions,1);
v=zeros(N_states,N_steps);
v(:,1)=v_ini;
q=zeros(N_states*N_actions,N_steps);
q(:,1)=q_ini;
for k=1:N_steps-1
    v(:,k+1)=pi_m*R + gamma*pi_m*P*v(:,k);
    q(:,k+1)=R + gamma*P*pi_m*q(:,k);
end
