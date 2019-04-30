% Recycling robot
clear all clc;
alpha=.3;
beta=.6;
gamma=.9;
r_s=1;
r_w=.1;
r_lhs = -3;
r_r = 0;
% 2 states (h,l) 3 actions(s,w,r)
% P = [ hh s, hl s; hh w, hl w; ll s, lh s; ll w, lh w; ll r, lh r; ]
P = [alpha, 1- alpha; 1, 0; beta, 1 - beta; 1 , 0; 0, 1];
% R = []
fun = @(v) v - [max([r_s+ gamma*(P(1,1)*v(1) + P(1,2)*v(2)), r_w + gamma*v(1)]);
                max([P(3,1)*r_s + r_lhs*P(3,2) + gamma*(P(3,2)*v(2) + P(3,1)*v(1)), r_w + gamma*v(2), gamma*v(1)])];
v0 = [0;0];
v = fsolve(fun,v0)


