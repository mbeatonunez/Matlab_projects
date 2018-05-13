function sysploter(num,dem,gain)
sys = tf(num,dem)
figure(1),subplot(2,1,1), step(sys),subplot(2,1,2),impulse(sys);
T = feedback(sys*gain,1);
figure(2),pzmap(T),grid;
figure(3),rlocus(sys), grid;
end