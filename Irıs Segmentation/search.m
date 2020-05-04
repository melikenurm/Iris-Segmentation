%göz bebeði merkezini bulma
%INPUTS:
%rmin:minimum yarýçap(irisin 0.1'i)
%rmax:maximum yarýçap(irisin 0.8'i)
%x:iris merkezinin x koordinatý
%y:iris merkezinin y koordinatý
%OUTPUT:
%cp:göz bebeðinin merkezi
function [cp]=search(im,rmin,rmax,x,y,option)
rows=size(im,1);
cols=size(im,2);
sigma=0.5;%hassas aramada gauss standart sapmasý 0.5
maxrad=zeros(rows,cols);
maxb=zeros(rows,cols);
for i=(x-5):(x+5)
    for j=(y-5):(y+5)
        [b,r]=partiald(im,[i,j],rmin,rmax,sigma,600,option);
        maxrad(i,j)=r;
        maxb(i,j)=b;
    end
end
B=max(max(maxb));
[X,Y]=find(maxb==B);
radius=maxrad(X,Y);
cp=[X,Y,radius];



        