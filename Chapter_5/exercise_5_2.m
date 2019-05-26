% We study the off-policy implementation
clear
% Definition of variables
random_walk_set_up
N_epi=20000;

% Optimum solution
v_off=(eye(size(pi_off*P)) - gamma*pi_off*P)\(pi_off*R);
v4_theory=v_off(4);

v_mc = montecarlo_importance(N_epi,R_W,gamma);
% Results comparison
[v4_theory mean(v_mc)]






