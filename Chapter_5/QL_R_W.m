function [q_ql] = QL_R_W(R_W,N_steps_value_ite)
%QL_R_W Summary of this function goes here
%   Detailed explanation goes here
    q_ql=zeros(R_W.N_states*R_W.N_actions, N_steps_value_ite);
    q_ql(:,1) = R_W.q_ini;
    for k=1:N_steps_value_ite
        epsilon = 1/3;
        u = rand(1,1);
        S_off=zeros(100,1);     % Buffer large enough
        S_off(1)=4;
        in=1;
        cont=1;
        R=0;
        action = 0;
        while in==1
            cont=cont+1;
            u=rand(1,1);
            if u > epsilon
                S_off(cont)=S_off(cont-1)+1;
                action = 1;
            else
                S_off(cont)=S_off(cont-1)-1;
                action = 2;
            end
            if S_off(cont)==1,in=0;end
            if S_off(cont)==7,R=1;in=0;end
            index_q = (S_off(cont-1) - 1)*2 + action; 
            [next_action,index_q_next] = max(R_W.pi_off(S_off(cont),:));
            q_ql(index_q, k) = q_ql(index_q, k)+R_W.alpha*...
            (R+R_W.gamma*next_action*q_ql(index_q_next, k)-...
             q_ql(index_q, k));
        end
        if k < N_steps_value_ite
            q_ql(:, k+1) = q_ql(:, k);
        end
%         pi_update = R_W.pi_off;
%         for i=1:R_W.N_states
%             [max_v] = max(pi_update(S_off(i),:));
%             pi_update(i,:);
%         end
    end
end

