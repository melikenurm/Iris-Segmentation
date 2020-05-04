%her yar��ap i�in merkez adaylar�n�n dairesel integrallerini bulma
%INPUTS:
%C(x,y):merkez aday�n�n koordinatlar�
%n:aral�k say�s�
%r:kullan�c�n�n belirledi�i aral�ktaki yar��ap(ad�m ad�m hepsi i�in hesaplanacak)
%part:iris aran�yorsa 0-45, 135-225, 315-360 dereceler aras�, g�z bebe�i
%ise dairenin tamam� 360 derece boyunca �evredeki pikseller hesaba kat�l�r
%OUTPUT:
%L:�evreye b�l�nm�� dairesel integral
function [L]=lineint(I,C,r,n,part)
rows=size(I,1);
cols=size(I,2);
theta=(2*pi)/n;% 0,6 derece aral�klarla
angle=theta:theta:2*pi;%0,6 dan 360 dereceye kadar 0,6�ar aral�klarla olu�turulan a�� dizisi
x=C(1)-r*sin(angle);%�emberlerin �zerindeki piksellerin x koordinatlar�
y=C(2)+r*cos(angle);%�emberlerin �zerindeki piksellerin y koordinatlar�
%orjin g�r�nt�n�n sol �st k��esi 
%x ekseni a�a��ya do�ru +
%y ekseni sa�a do�ru +
%a�� saat y�n�n�n tersine +
%x2=x1+r*sin(-theta)
%y2=y1+r*cos(-theta)
if (any(x>=rows)||any(y>=cols)||any(x<=1)||any(y<=1))
%g�r�nt�n�n i�inde olmayan bir koordinata sahip pikseli olan �ember=0
    L=0;
    return
end

if (strcmp(part,'pupil')==1)
          %g�z bebe�i g�z kapa�� ile �rt�lm�� olamaz, t�m �evre piksellerini
          %alabiliriz
          s=0;
          for i=1:n
          val=I(round(x(i)),round(y(i)));
          s=s+val;
          end
%           L=s/(2*pi*r);
          L=s/n;%n=600 tane nokta i�in normalizasyon
end

if(strcmp(part,'iris')==1)
          s=0;
          %iris g�z kapa�� ile �rt�lm�� olabilece�inden
          %�emberin sadece +-45 ve 135-225 dereceler aras� yanlardaki piksellerin toplam� al�n�r 
          for i=1:round((n/8))%600/8=ilk 75 tane noktan�n intensitylerini topla(75-0,6=0-45 derece aras�)
          val=I(round(x(i)),round(y(i)));
          s=s+val;
          end
          
          for i=(round(3*n/8))+1:round((5*n/8))%225-375 aras� noktalar(135-225 derece aras�)
          val=I(round(x(i)),round(y(i)));
          s=s+val;
          end
          
          for i=round((7*n/8))+1:(n)%525-600 aras�ndaki pikseller(315-360 derece aras�(-45))
          val=I(round(x(i)),round(y(i)));
          s=s+val;
          end
%           L=s/(2*pi*r);
          L=(2*s)/n;%toplam 300 tane piksel al�nd��� i�in normalizasyon n/2 ile yap�l�r
end