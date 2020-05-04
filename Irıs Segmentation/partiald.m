%dairesel integralin t�revini bulma
%INPUTS:
%C:merkez aday�n�n koordinatlar�
%rmin,rmax:kullan�c�n�n belirledi�i max ve min iris yar��aplar�
%n:aral�k say�s�(noktalar�n bulundu�u �okgenin kenar say�s�)
%part:iris veya pupil
%sigma:gauss standart sapmas�
%OUTPUTS:
%r:maksimum parlakl�k fark�n�n oldu�u yar��ap
%b:maksimum parlakl�k fark�
function [b,r]=partiald(I,C,rmin,rmax,sigma,n,part)
R=rmin:rmax;
count=size(R,2);
%belirledi�imiz s�n�rlardaki her yar��ap de�eri i�in o uzakl�ktaki
%pikseller integralle toplan�r
for k=1:count
[L(k)]=lineint(I,C,R(k),n,part);
if L(k)==0
    %verdi�imiz yar��apla g�r�nt�n�n d���na ��k�l�rsa
     L(k)=[];
    break;
end
end
%elde etti�imiz �emberlerin t�revi
D=diff(L);
D=[0 D];%rmin yar��ap�ndaki �emberden �nce �ember olmad��� i�in onun t�revi 0 kabul edilir

f=fspecial('gaussian',[1,5],sigma);%1 boyutlu 5 elemanl� gauss filtresi 

blur=convn(D,f,'same');%t�rev vekt�r� gauss ile yumu�at�l�r
%sonu�ta ayn� boyutta yumu�at�lm�� vekt�r(blur) elde edilir
blur=abs(blur);%fark�n pozitif olmas� i�in mutlak de�er al�n�r
[b,i]=max(blur);%fark�n max oldu�u eleman�n indisi bulunur
r=R(i);%bu indisteki yar��ap al�n�r

