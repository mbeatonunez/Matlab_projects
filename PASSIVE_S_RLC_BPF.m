function PASSIVERLCBPF(R,L,C)
G = tf([R 0],[L 1/C R])
bode(G);
end
