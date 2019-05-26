function [v_mc] = montecarlo_importance(N_epi,R_W,gamma)
% MC off-policy algorithm. Only for state 4
v_mc=zeros(1,N_epi);
for k=1:N_epi
    S_off=zeros(100,1);     % Buffer large enough
    S_off(1)=4;
    in=1;
    cont=1;
    R=0;
    cont_r=0;
    cont_l=0;
    while in==1
    	cont=cont+1;
        u=rand(1,1);
        if u< 1/2
            S_off(cont)=S_off(cont-1)+1;
            cont_r=cont_r+1;
        else
            S_off(cont)=S_off(cont-1)-1;
            cont_l=cont_l+1;
        end
        if S_off(cont)==1,in=0;end
        if S_off(cont)==7,R=1;in=0;end
    end
    pi_col_index = (S_off(cont)-1)*2 +1;
	f= ((R_W.pi_off(S_off(cont),pi_col_index)^cont_r)*...
        (R_W.pi_off(S_off(cont),pi_col_index+1)^cont_l))/ ...
    ((R_W.pi_rp(S_off(cont),pi_col_index)^cont_r)*...
    (R_W.pi_rp(S_off(cont),pi_col_index+1)^cont_l));
    v_mc(k)=f*gamma^(cont-2)*R;
end