%her yarıçap için merkez adaylarının dairesel integrallerini bulma
%INPUTS:
%C(x,y):merkez adayının koordinatları
%n:aralık sayısı
%r:kullanıcının belirlediği aralıktaki yarıçap(adım adım hepsi için hesaplanacak)
%part:iris aranıyorsa 0-45, 135-225, 315-360 dereceler arası, göz bebeği
%ise dairenin tamamı 360 derece boyunca çevredeki pikseller hesaba katılır
%OUTPUT:
%L:çevreye bölünmüş dairesel integral
function [L]=lineint(I,C,r,n,part)
rows=size(I,1);
cols=size(I,2);
theta=(2*pi)/n;% 0,6 derece aralıklarla
angle=theta:theta:2*pi;%0,6 dan 360 dereceye kadar 0,6şar aralıklarla oluşturulan açı dizisi
x=C(1)-r*sin(angle);%çemberlerin üzerindeki piksellerin x koordinatları
y=C(2)+r*cos(angle);%çemberlerin üzerindeki piksellerin y koordinatları
%orjin görüntünün sol üst köşesi 
%x ekseni aşağıya doğru +
%y ekseni sağa doğru +
%açı saat yönünün tersine +
%x2=x1+r*sin(-theta)
%y2=y1+r*cos(-theta)
if (any(x>=rows)||any(y>=cols)||any(x<=1)||any(y<=1))
%görüntünün içinde olmayan bir koordinata sahip pikseli olan çember=0
    L=0;
    return
end

if (strcmp(part,'pupil')==1)
          %göz bebeği göz kapağı ile örtülmüş olamaz, tüm çevre piksellerini
          %alabiliriz
          s=0;
          for i=1:n
          val=I(round(x(i)),round(y(i)));
          s=s+val;
          end
%           L=s/(2*pi*r);
          L=s/n;%n=600 tane nokta için normalizasyon
end

if(strcmp(part,'iris')==1)
          s=0;
          %iris göz kapağı ile örtülmüş olabileceğinden
          %çemberin sadece +-45 ve 135-225 dereceler arası yanlardaki piksellerin toplamı alınır 
          for i=1:round((n/8))%600/8=ilk 75 tane noktanın intensitylerini topla(75-0,6=0-45 derece arası)
          val=I(round(x(i)),round(y(i)));
          s=s+val;
          end
          
          for i=(round(3*n/8))+1:round((5*n/8))%225-375 arası noktalar(135-225 derece arası)
          val=I(round(x(i)),round(y(i)));
          s=s+val;
          end
          
          for i=round((7*n/8))+1:(n)%525-600 arasındaki pikseller(315-360 derece arası(-45))
          val=I(round(x(i)),round(y(i)));
          s=s+val;
          end
%           L=s/(2*pi*r);
          L=(2*s)/n;%toplam 300 tane piksel alındığı için normalizasyon n/2 ile yapılır
end