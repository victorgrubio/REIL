clear
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

v_opt = v2;

% Part b)
% We know that policy 2 is optimal
A=zeros(2,1000);
for k =1:1000
    r1 = rand(1, 4); % Start with 3 random numbers that don't sum to 1.
    r1 = r1 / sum(r1);  % Normalize so the sum is 1.
    r2 = rand(1, 4); % Start with 3 random numbers that don't sum to 1.
    r2 = r2 / sum(r2);  % Normalize so the sum is 1.
    pi_rand = [r1;r2];
    v_rand =inv( (eye(size(P,2)) - gamma*pi_rand*P) )*(pi_rand*R);
    A(:,k) = v_rand;
end

plot([v_opt(1) v_opt(1)],[-10 v_opt(2)],'--b','LineWidth',2),hold
plot([-10 v_opt(1)],[v_opt(2) v_opt(2)],'--b','LineWidth',2),
plot(v_opt(1),v_opt(2),'b*','LineWidth',5)
plot(A(1,:),A(2,:),'.r')
hold off
axis([-10 6 -10 6]),grid
xlabel('Coordinate 1')
ylabel('Coordinate 2')




