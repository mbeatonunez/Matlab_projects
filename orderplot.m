function orderplot(num,den,stp)
%% Print transfer function to the screen
F=tf(num,den)

%% display zero/pole plot
fvtool(num,den,'polezero'),grid on;
ax =gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

%% print poles and zeros to the screen
[b,a] = eqtflength(num,den);
[Zeros,Poles,k] = tf2zp(b,a)
text(real(Zeros)+.1,imag(Zeros),'Zero')
text(real(Poles)+.1,imag(Poles),'Pole')

%% Displat step response
figure(2),step(stp*F),grid on;
grid on
end