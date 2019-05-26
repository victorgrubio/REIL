function [q_sarsa] = SARSA_R_W(R_W,N_steps_value_ite)
%SARSA_R_W Summary of this function goes here
%   Detailed explanation goes here
v_td=zeros(R_W.N_states,N_steps_value_ite);
    for k=1:N_steps_value_ite
        S_off=zeros(100,1);     % Buffer large enough
        S_off(1)=4;
        in=1;
        cont=1;
        R=0;
        while in==1
            cont=cont+1;
            u=rand(1,1);
            if u>1/2,
                S_off(cont)= S_off(cont-1) + 1;
            else
                S_off(cont)= S_off(cont-1) - 1;
            end
            if S_off(cont)==1,in=0;end
            if S_off(cont)==7,R=1;in=0;end
            v_td(S_off(cont-1)) = v_td(S_off(cont-1)) + ...
                R_W.alpha*(R + R_W.gamma*v_td(S_off(cont)) - ...
                v_td(S_off(cont-1)));
        end
        if k < N_steps_value_ite
            v_td(:, k+1) = v_td(:, k);
        end
    end
end

