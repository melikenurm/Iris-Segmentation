clear all;
path='C:\Users\Melike Nur Mermer\Desktop\UBIRIS_200_150_R\Sessao_1';
nofimages=1;
% i=nofimages;
for i=1:nofimages
path1=strcat(path,'\',num2str(i),'\Img_',num2str(i),'_1_3.jpg');
I=imread(path1);
%piksel cinsinden min ve max iris yarýçaplarý
rmin=30;
rmax=100;

[ci,cp,out]=thresh(I,rmin,rmax);

% imwrite(out,strcat('C:\Users\Melike Nur Mermer\Desktop\Bilgisayarla Görme\bgvizeodevi\Melike Nur Mermer - 15501010 - Vize\segmented\',num2str(i),'.jpg'));
imshow(I);
figure
imshow(out);
end
