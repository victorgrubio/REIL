clear clc;
P=[0.6 .4;0.1 .9];
% To be completed
d = [0.5; 0.5]';
for i=1:limit
    eigen = eig(P);
    d = d*P;
    P = P*P;
end
fprintf('FINISHED')

