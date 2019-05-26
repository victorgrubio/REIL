% Analysis Random Walk problem
clear all
addpath /home/victor/code/MSTC/reinforcement/Chapter_4;
random_walk_set_up;
N_steps_value_ite=10000;
% Optimum value
v_opt=inv(eye(R_W.N_states)-R_W.gamma*R_W.pi_opt*R_W.P)*R_W.pi_opt*R_W.R;
q_opt=inv(eye(R_W.N_states*R_W.N_actions)-R_W.gamma*R_W.P*R_W.pi_opt)*R_W.R;

% Solution of the Bellman linear equations
% Solution of the V/Q equations
v_rp=inv(eye(R_W.N_states)-R_W.gamma*R_W.pi_rp*R_W.P)*R_W.pi_rp*R_W.R;
q_rp=inv(eye(R_W.N_states*R_W.N_actions)-R_W.gamma*R_W.P*R_W.pi_rp)*R_W.R;

[v_pe_bell, q_pe_bell]=policy_evaluation(R_W.gamma,R_W.N_states,R_W.N_actions,...
    N_steps_value_ite,R_W.P,R_W.R,R_W.pi_rp);
[v_rp v_pe_bell(:,N_steps_value_ite)]

% Value iteration
[v_vi, q_vi] = value_iteration(R_W.gamma,R_W.N_states,R_W.N_actions,...
    N_steps_value_ite,R_W.P,R_W.R,R_W.pi_rp);
[v_opt v_vi(:,N_steps_value_ite)]

% Policy iteration
[v_pi, q_pi] = policy_evaluation(R_W.gamma,R_W.N_states,R_W.N_actions,...
    N_steps_value_ite,R_W.P,R_W.R,R_W.pi_rp);
[v_opt v_pi(:,N_steps_value_ite)]

% TD V function. Random policy
[v_td] = TD_R_W(R_W,N_steps_value_ite);
[v_rp v_td(:,N_steps_value_ite)]

% QL algorithm
R_W.alpha=.1;
[q_ql] = QL_R_W(R_W,N_steps_value_ite);
[v_opt q_ql(1:2:end,end)]


% SARSA algorithm
R_W.alpha=.1;
[q_sarsa] = SARSA_R_W(R_W,N_steps_value_ite);
[v_opt q_sarsa(1:2:end,end)]


