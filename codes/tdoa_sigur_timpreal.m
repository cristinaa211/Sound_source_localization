function [xs,ys,zs]=tdoa_timpreal(t12,t13,t14,x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4)
x=[x1,x2,x3,x4];
y=[y1,y2,y3,y4];
z=[z1,z2,z3,z4];
v=343; 
M=4;
%%HIPERBOLELE
%for i=1:M
   % a(i)=tdoa_dist(i)/2;
    %c(i)=abs(x_pos(1)-x_pos(i))/2;
    %b(i)=sqrt(abs(c(i)^2-a(i)^2));
    %figure
    %[sp]=EllipseHyperbolaSamplePointGeneration(x_pos(i),y_pos(i),a(i),b(i),sita,1,-300,300,-300,300);  
%end
A=zeros(4,1); B=zeros(4,1); C=zeros(4,1); D=zeros(4,1);
if t12 == 0 | t13 == 0 | t14 == 0
    'S-a detectat o sursã acusticã care se aflã într-o sferã cu raza de aproximativ un metru!'
    xs=0;ys=0;zs=0;
else
    t122=t12;
    t133=t13;
    t144=t14;

tdoa_p=[0,t122,t133,t144];
for i=3:4
   A(i) = (1/(v*tdoa_p(i)))*(-2*x1+2*x(i)) - (1/(v*tdoa_p(2)))*(-2*x1+2*x2);
   B(i) = (1/(v*tdoa_p(i)))*(-2*y1+2*y(i)) - (1/(v*tdoa_p(2)))*(-2*y1+2*y2);
   C(i) = (1/(v*tdoa_p(i)))*(-2*z1+2*z(i)) - (1/(v*tdoa_p(2)))*(-2*z1+2*z2);
   Sum1 = (x1^2)+(y1^2)+(z1^2)-(x(i)^2)-(y(i)^2)-(z(i)^2);
   Sum2 = (x1^2)+(y1^2)+(z1^2)-(x2^2)-(y2^2)-(z2^2);
   Dm(i) = v*(tdoa_p(i) - tdoa_p(2)) + (1/(v*tdoa_p(i)))*Sum1 - (1/(v*tdoa_p(2)))*Sum2;  
end
M = zeros(4,3);
D = zeros(4,1);
for i=1:4
    M(i,1) = A(i);
    M(i,2) = B(i);
    M(i,3) = C(i);
    D(i) = Dm(i);
end
M = M(3:4,:);
D = D(3:4);
D = D.*-1;
Minv = pinv(M);
T = Minv*(D);
xs = T(1)
ys = T(2)
zs = T(3)
X=[xs,x1]; X1=[xs,x2];X2=[xs,x3];X3=[xs,x4];
Y=[ys,y1]; Y1=[ys,y2];Y2=[ys,y3];Y3=[ys,y4];
Z=[zs,z1];Z1=[zs,z2];Z2=[zs,z3];Z3=[zs,z4];
 h=figure;
title('Pozitionarea microfoanelor si a sursei de sunet' );
scatter3(xs,ys,zs,'red','s','filled'); 
hold on;
scatter3(x1,y1,z1,'blue','h','filled'); 
hold on;
scatter3(x2,y2,z2,'green','h','filled'); 
hold on;
scatter3(x3,y3,z3,'yellow','h','filled'); 
hold on;
scatter3(x4,y4,z4,'black','h','filled'); 
hold on;
xlabel('Axa x');ylabel('Axa y'); zlabel('Axa z');
xlim([-1.5 1.5]);ylim([-1.5 1.5]);zlim([-1.5 1.5]);
legend('"Sursa de emisie estimata"', '"Microfonul 1"', '"Microfonul 2"','"Microfonul 3"','"Microfonul 4"');
view(30,30);
plot3(X,Y,Z);hold on;
plot3(X1,Y1,Z1); hold on;
plot3(X2,Y2,Z2); hold on;
plot3(X3,Y3,Z3);
grid on; hold off;
saveas(h, 'Rezultate.jpg' ,'jpeg')
%dd=[t12*v,t13*v,t14*v];
%p1=[x1,y1];p2=[x2,y2];p3=[x3,y3];p4=[x4,y4];
%[h1,h2]=hiperbol(p1,p2,dd(1));
%[h3,h4]=hiperbol(p1,p3,dd(2));
%[h5,h6]=hiperbol(p1,p4,dd(3));
%figure 
%plot(h1,h2);
%hold on;
%plot(h3,h4);
%hold on;
%plot(h5,h6);
%hold on;
%scatter(xs,ys,'magenta','o','filled');
%hold on;
%scatter(x1,y1,'blue','o','filled'); 
%hold on;
%scatter(x2,y2,'green','o','filled'); 
%hold on;
%scatter(x3,y3,'yellow','o','filled'); 
%hold on;
%scatter(x4,y4,'black','o','filled'); 
%grid on;
%hold off;
end 
