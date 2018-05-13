function bppf(wc1,wc2)
 w = (wc1+wc2)/100:(wc1+wc2)/100:1000*(wc1+wc2);
H=((j*w)+wc1)./((j*w)+wc2);
M = abs(H);
thetaR= angle(H);
theta = radtodeg(thetaR);
Mdb = 20*log(M);
subplot(2,1,1), semilogx(w,Mdb), grid on; subplot(212), semilogx(w,theta);
grid on