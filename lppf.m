function lppf(wc)
 w = wc/100:wc/100:1000*wc);
H=wc./((j*w)+wc);
M = abs(H);
thetaR= angle(H);
theta = radtodeg(thetaR);
Mdb = 20*log(M);
subplot(2,1,1), semilogx(w,Mdb), grid on; subplot(212), semilogx(w,theta);
grid on