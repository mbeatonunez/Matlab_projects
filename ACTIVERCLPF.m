function ACTIVERCLPF(R,C)
fc=1/(2*pi*R*C);
f=[fc/100:fc/100:1000*fc];
w=f*2*pi;
wc=2*pi*fc;
subplot (3,1,1)
HM=abs((1)./(j*w*R*C));
semilogx(w,HM)
grid on
title('|H(j\omega)|')
xlabel ('\omega')
ylabel ('|H(j\omega)|')
subplot (3,1,2)
HMDB=20*log(HM);
semilogx(w,HMDB)
grid on
title('|H(j\omega)| dB')
xlabel ('\omega')
ylabel ('|H(j\omega)| dB')
theta=angle((1)./(j*w*R*C));
theta=angle((1)./(j*w*R*C));
subplot (3,1,3)
degree=theta*180/pi;
semilogx(w,degree)
grid on
title('\theta(j\omega)')
xlabel('\omega')
ylabel('\theta(j\omega)')
end
