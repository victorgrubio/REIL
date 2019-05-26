clear
% Definition of variables
random_walk_set_up
N_epi=20000;

% Optimum solution
v_rp=(eye(size(pi_rp*P,1))-gamma*pi_rp*P)\(pi_rp*R);

v_mc = montecarlo(N_epi,R_W,gamma);
[v_rp v_mc(:,N_epi)]






