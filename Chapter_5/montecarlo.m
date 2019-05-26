function [v_mc] = montecarlo(N_epi,R_W,gamma)
% MC every visit algorithm
    N=zeros(R_W.N_states,1);
    v_mc=zeros(R_W.N_states,N_epi);
    for k=1:N_epi
        S=zeros(100,1);
        S(1)=4;
        in=1;
        cont=1;
        R=0;
        while in==1
            cont=cont+1;
            S(cont)=S(cont-1)+sign(randn(1,1));
            if S(cont)==1,in=0;end
            if S(cont)==7,R=1;in=0;end
        end
        g=0;
        for kk=cont-1:-1:1
            if S(kk+1) == 7
                R = 1;
            else
                R = 0;
            end
            g = gamma*g + R;
            N(S(kk)) = N(S(kk)) + 1;
            v_mc(S(kk),k) = v_mc(S(kk),k)+(1/N(S(kk)))*(g-v_mc(S(kk),k));
        end
        v_mc(:,k+1)=v_mc(:,k);
    end
end

