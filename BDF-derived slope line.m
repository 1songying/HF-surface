function [XSP,YSP] =f_length2(XX,YY)
 xp=50*XX+250;yp=50*YY+250;
 t=0:pi/200:2*pi;
 xp1=2*sin(t)+xp;
 yp1=2*cos(t)+yp;
 plot(xp1,yp1,'r','Linewidth',2)
 hold on
peakx=[116.685,196.19,313.355,373.765];peaky=[94.545,392.095,369.72,143.645]; 
N=0;
for i=1:4
[x,y] = ode23tb('odefun',[XX (peakx(i)-250)/50],YY);   
NN=x(2)-x(1);NN=NN/100;x1=x(1):NN:x(2);
NN=y(2)-y(1);NN=NN/100;y1=y(1):NN:y(2);
Z1=-0.75*((x1.^2+y1-4).^2+(y1.^2+x1-7).^2)+451;
X=50*x+250;
Y=50*y+250;
d=sqrt((X-peakx(i)).^2+(Y-peaky(i)).^2);
axis([0,500,0,500]);
if(Z1(1)<Z1(2))
    if min(d)<1    
    N=1;
    X1=X;Y1=Y;
    end
end
[x,y] = ode23tb('odefun1',[YY (peaky(i)-250)/50],XX);
NN=x(2)-x(1);NN=NN/100;x1=x(1):NN:x(2);
NN=y(2)-y(1);NN=NN/100;y1=y(1):NN:y(2);
Z2=-0.75*((x1.^2+y1-4).^2+(y1.^2+x1-7).^2)+451;
Y=50*x+250;
X=50*y+250;
d=sqrt((X-peakx(i)).^2+(Y-peaky(i)).^2);
axis([0,500,0,500]);
if(Z2(1)<Z2(2))
  if min(d)<1   
    N=2;
    X2=X;Y2=Y;
  end
end
if N>0
    break;
end
end
if(N==1)
    XSP=X1;YSP=Y1;
    plot(X1,Y1,'r','Linewidth',2);
end
if(N==2)
    XSP=X2;YSP=Y2;
     plot(X2,Y2,'r','Linewidth',2);
end
end
