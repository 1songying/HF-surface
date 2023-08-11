clear;clc
M=96;
ssimval=zeros(1,M)
 for In=0.2:-0.002:0.01
X=-5:In:5;
Y=-5:In:5;
x=50*X+250;
y=50*Y+250;
[xx1,yy1]=meshgrid(X,Y);
ZZ=(xx1.^2+yy1-4).^2+(yy1.^2+xx1-7).^2;%
[xx,yy]=meshgrid(x,y);
zz=-0.75*ZZ+450;

h=In*50;
N=length(x);
%curvature k
k=zeros(N,N);
ex=(zz(3:N,2:N-1)-zz(1:N-2,2:N-1))/(2*h);
ey=(zz(2:N-1,3:N)-zz(2:N-1,1:N-2))/(2*h);
exx=(zz(3:N,2:N-1)+zz(1:N-2,2:N-1)-2*zz(2:N-1,2:N-1))/(h^2);
eyy=(zz(2:N-1,3:N)+zz(2:N-1,1:N-2)-2*zz(2:N-1,2:N-1))/(h^2);
exy=(-zz(1:N-2,3:N)+zz(3:N,3:N)+zz(1:N-2,1:N-2)-zz(3:N,1:N-2))/(4*h^2);
k(2:N-1,2:N-1)=(exx.*ey.^2-2*exy.*ex.*ey+eyy.*ex.^2)./(ex.^2+ey.^2).^(3/2);%k<0,表示发散？
k(N,:)=0;k(:,N)=0;
%curvature k1
syms a b c
c=-0.75*(((((a-250)/50))^2+((b-250)/50)-4)^2+(((b-250)/50)^2+(a-250)/50-7)^2)+450;
ex1=diff(c,a);
ey1=diff(c,b);
exx1=diff(c,a,2);
eyy1=diff(c,b,2);
exy1=diff(ex1,b);

ex2=9/25 - (3*(xx/1250 - 1/5).*(yy/50 + (xx/50 - 5).^2 - 9))/2 - (3*(yy/50 - 5).^2)/100 - (3*xx)/5000;
ey2=27/100 - (3*(yy/1250 - 1/5).*(xx/50 + (yy/50 - 5).^2 - 12))/2 - (3*(xx/50 - 5).^2)/100 - (3*yy)/5000;
exx2=51/5000 - (3*(xx/50 - 5).^2)/2500 - (3*(xx/1250 - 1/5).^2)/2 - (3*yy)/125000;
eyy2=69/5000 - (3*(yy/50 - 5).^2)/2500 - (3*(yy/1250 - 1/5).^2)/2 - (3*xx)/125000;
exy2=3/250 - (3*yy)/125000 - (3*xx)/125000;
k1=(exx2.*ey2.^2-2*exy2.*ex2.*ey2+eyy2.*ex2.^2)./(ex2.^2+ey2.^2).^(3/2);
%plot k1
%h2=pcolor(xx,yy,k1);set(h2,'LineStyle','none');hold on
%contour(xx,yy,zz,[-500:50:600,410,320,430,440,445,449],'color',[0 0 0],'ShowText','on');
%set(gca,'XTick',0:100:500,'FontSize',25);set(gca,'YTick',0:100:500);set(gcf,'unit','centimeters','position',[8,0,25,20]);

error=abs(k1-k);error(1,:)=0;error(N,:)=0;error(:,1)=0;error(:,N)=0;
RMSD(M)=mean(mean((error)^2)).^0.5;
pjjdwc(M)=mean(mean(error));
xdjdwc(M)=sum(sum(error))/sum(sum(abs(k-mean(mean(k)))));
ssimval(M)=ssim(k,k1)%SSIM计算

M=M-1;
In
 end