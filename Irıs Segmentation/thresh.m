%ön iþlemler ve eþikleme yapar
%tümleþik türev iþlemi sonucunda elde edilen iris ve göz bebeði merkezleri
%ve yarýçaplarýný döndürür
%eþikleme1=intensity 0.5ten küçük olmalý
%eþikleme2=belirlenen yarýçap sýnýrlarýna göre görüntünün uygun yerinde
%olmalý
%eþikleme3=3x3lük komþuluk matrisi içinde en koyu intensitye sahip olmalý
%INPUTS:
%rmin ,rmax:kullanýcýnýn belirlediði max ve min iris yarýçaplarý
%OUTPUTS:
%cp:[xc,yc,r] sýrasýyla göz bebeði merkez koordinatlarý ve yarýçapý
%ci:[xc,yc,r] sýrasýyla iris merkez koordinatlarý ve yarýçapý
%out:iris ve göz bebeði sýnýrlarýna çember çizilmiþ görüntü
function [ci,cp,out]=thresh(I,rmin,rmax)
I=im2double(I);
pimage=I;
%öncelikle morfolojik iþlemlerle görüntüdeki parlamalar yok edilir, tersini alýp
%siyah olan boþluklar dolduruluyor, sonra tekrar tersi alýnýyor
I=imcomplement(imfill(imcomplement(I),'holes'));

satir=size(I,1);%150
sutun=size(I,2);%200
%iris intensity deðeri 0.5ten küçük olan bölgelerde bulunabilir 
%görüntüyü doublea çevirdikten sonra 0.5ten küçük intensity deðeri olan piksellerin x ve y koordinatlarý bulunuyor
[X,Y]=find(I<0.5);

s=size(X,1);%bu deðerlerde kaç tane nokta var
for k=1:s 
    if (X(k)>rmin)&&(Y(k)>rmin)&&(X(k)<=(satir-rmin))&&(Y(k)<(sutun-rmin))%bu piksel bizim belirlediðimiz sýnýrlarýn merkezi olabilir mi?
       %görüntünün köþelerinden belirlediðimiz min yarýçap kadar uzak olmalý
            A=I((X(k)-1):(X(k)+1),(Y(k)-1):(Y(k)+1));%pikselin 3x3 komþularýndan oluþan matris
            M=min(min(A));%komþularý içinden en koyu piksel bu mu
           if I(X(k),Y(k))~=M %en koyu piksel deðilse merkez olamaz
               %dizi boyutlarý kaymasýn diye önce nan yapýlýr döngüden
               %çýkýnca silinecek
              X(k)=NaN;
              Y(k)=NaN;
           end
    end
end
%komþularý içinden en koyu olmayan pikselleri sil
v=find(isnan(X));
X(v)=[];
Y(v)=[];
%belirlediðimiz min yarýçapýn merkezi olamayacak koordinatta bulunan
%en köþelerdeki pikselleri sil
index=find((X<=rmin)|(Y<=rmin)|(X>(satir-rmin))|(Y>(sutun-rmin)));
X(index)=[];
Y(index)=[];  

N=size(X,1);%merkez olma ihtimali bulunmayan pikselleri sildikten sonraki boyut

maxb=zeros(satir,sutun);
maxrad=zeros(satir,sutun);
%merkez olabilecek tüm noktalar için tümleþik türev iþlemi ile 
%intensitynin en çok deðiþim gösterdiði yarýçap(maxrad) ve bu deðiþim deðeri(maxb) bulunur 
for j=1:N
    [b,r]=partiald(I,[X(j),Y(j)],rmin,rmax,1,600,'iris');%coarse search
    maxb(X(j),Y(j))=b;
    maxrad(X(j),Y(j))=r;
end
[x,y]=find(maxb==max(max(maxb)));%farkýn en yüksek olduðu pikselin koordinatlarý
%farkýn en yüksek olduðu pikselin 10x10 komþularý için yeniden kýsmi türeve
%bakýlýr
ci=search(I,rmin,rmax,x,y,'iris');%fine search
%bulunan iris yarýçapýnýn 0.1-0.8'i kadar olabilecek aralýkta gözbebeði
%merkezi ve yarýçapý aranýr
cp=search(I,round(0.1*ci(3)),round(0.8*ci(3)),ci(1),ci(2),'pupil');
% cp=search(I,round(0.1*r),round(0.8*r),ci(1),ci(2),'pupil');
%giriþ görüntüsü üzerinde iris ve gözbebeðinin etrafýna çember çizilir
out=drawcircle(pimage,[ci(1),ci(2)],ci(3),600);
out=drawcircle(out,[cp(1),cp(2)],cp(3),600);
