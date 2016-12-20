function  phi = CV_Imp2D(phi,Img,I_Area,I_M,epsilon,delt)

Heviside = 1/2*(1+2/pi*atan(phi/epsilon));

Ih =Img.*Heviside;
Ihs = sum(Ih(:));
Hds = sum(Heviside(:));

Avr_in = Ihs/Hds;
Avr_out = (I_M-Ihs)/(I_Area-Hds);
phi = phi + delt*(Img - (Avr_in+Avr_out)/2 );
