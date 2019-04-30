clear clc all;
gamma=.9;
R=[-1;.6;.5;-.9];
P=[0.8 0.2;0.2 0.8;0.3 0.7;0.9 0.1];
pi1=[1 0 0 0;0 0 1 0];
pi2=[0 1 0 0;0 0 1 0];
pi3=[1 0 0 0;0 0 0 1];
pi4=[0 1 0 0;0 0 0 1];

v1=inv( (eye(size(P,2)) - gamma*pi1*P) )*(pi1*R);
v2=inv( (eye(size(P,2)) - gamma*pi2*P) )*(pi2*R);
v3=inv( (eye(size(P,2)) - gamma*pi3*P) )*(pi3*R);
v4=inv( (eye(size(P,2)) - gamma*pi4*P) )*(pi4*R);
q1=inv( (eye(size(P,1)) - gamma*P*pi1) )*R;
q2=inv( (eye(size(P,1)) - gamma*P*pi2) )*R;
q3=inv( (eye(size(P,1)) - gamma*P*pi3) )*R;
q4=inv( (eye(size(P,1)) - gamma*P*pi4) )*R;

%We verify 
v1_q = pi1*q1;
v2_q = pi2*q2;
v3_q = pi3*q3;
v4_q = pi4*q4;

q1_v = R + gamma*P*v1;
q2_v = R + gamma*P*v2;
q3_v = R + gamma*P*v3;
q4_v = R + gamma*P*v4;





