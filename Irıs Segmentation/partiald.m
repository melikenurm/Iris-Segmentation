%dairesel integralin türevini bulma
%INPUTS:
%C:merkez adayýnýn koordinatlarý
%rmin,rmax:kullanýcýnýn belirlediði max ve min iris yarýçaplarý
%n:aralýk sayýsý(noktalarýn bulunduðu çokgenin kenar sayýsý)
%part:iris veya pupil
%sigma:gauss standart sapmasý
%OUTPUTS:
%r:maksimum parlaklýk farkýnýn olduðu yarýçap
%b:maksimum parlaklýk farký
function [b,r]=partiald(I,C,rmin,rmax,sigma,n,part)
R=rmin:rmax;
count=size(R,2);
%belirlediðimiz sýnýrlardaki her yarýçap deðeri için o uzaklýktaki
%pikseller integralle toplanýr
for k=1:count
[L(k)]=lineint(I,C,R(k),n,part);
if L(k)==0
    %verdiðimiz yarýçapla görüntünün dýþýna çýkýlýrsa
     L(k)=[];
    break;
end
end
%elde ettiðimiz çemberlerin türevi
D=diff(L);
D=[0 D];%rmin yarýçapýndaki çemberden önce çember olmadýðý için onun türevi 0 kabul edilir

f=fspecial('gaussian',[1,5],sigma);%1 boyutlu 5 elemanlý gauss filtresi 

blur=convn(D,f,'same');%türev vektörü gauss ile yumuþatýlýr
%sonuçta ayný boyutta yumuþatýlmýþ vektör(blur) elde edilir
blur=abs(blur);%farkýn pozitif olmasý için mutlak deðer alýnýr
[b,i]=max(blur);%farkýn max olduðu elemanýn indisi bulunur
r=R(i);%bu indisteki yarýçap alýnýr

