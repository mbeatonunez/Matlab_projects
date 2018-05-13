function PASSIVE_SP_RLC_BPF(R,L,C) 
H = tf([1/(R*C) 0],[1 1/(R*C) 1/(L*C)])
bode(H);
end
