function [v_td] = TD_R_W(R_W,N_epi)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    v_td=zeros(R_W.N_states,N_epi);
    for k=1:N_epi
        S_off=zeros(100,1);     % Buffer large enough
        S_off(1)=4;
        in=1;
        cont=1;
        R=0;
        while in==1
            cont=cont+1;
            u=rand(1,1);
            % get the probability of next state based on pi
            prob = 1/2;
            if u<prob,
                S_off(cont)= S_off(cont-1) + 1; % action obtains next state
            else
                S_off(cont)= S_off(cont-1) - 1; % action obtains next state
            end
            if S_off(cont)==1,in=0;end
            if S_off(cont)==7,R=1;in=0;end
            v_td(S_off(cont-1), k) = v_td(S_off(cont-1), k) + R_W.alpha*...
            (R + R_W.gamma*v_td(S_off(cont), k) - v_td(S_off(cont-1), k));
            S_off(cont-1) = S_off(cont);
        end
        if k < N_epi
            v_td(:, k+1) = v_td(:, k);
        end
    end
end
%         for kk=1:cont-1
%             v_td(S_off(kk), k) = v_td(S_off(kk), k) + R_W.alpha*...
%             (R + R_W.gamma*v_td(S_off(kk+1), k) - v_td(S_off(kk), k));
%             S_off(kk) = S_off(kk + 1);
%         end
