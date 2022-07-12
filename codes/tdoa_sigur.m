function [xs,ys,zs]=tdoa_sigur(t122,t133,t144,x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4,x_real,y_real,z_real)
x=[x1,x2,x3,x4];
y=[y1,y2,y3,y4];
z=[z1,z2,z3,z4];
v=343;
mic=4;
%%HIPERBOLELE
%for i=1:M
   % a(i)=tdoa_dist(i)/2;
    %c(i)=abs(x_pos(1)-x_pos(i))/2;
    %b(i)=sqrt(abs(c(i)^2-a(i)^2));
    %figure
    %[sp]=EllipseHyperbolaSamplePointGeneration(x_pos(i),y_pos(i),a(i),b(i),sita,1,-300,300,-300,300);
   
%end
tdoa_p=[0,t122,t133,t144];
A=zeros(mic,1); B=zeros(mic,1); C=zeros(mic,1); D=zeros(mic,1);
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
h = figure;
%title('Pozitionarea microfoanelor si a sursei de sunet' );
view(30,30);
scatter3(x_real,y_real,z_real, 'green');
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
xlabel('x-axis');ylabel('y-axis'); zlabel('z-axis');
xlim([-15 15]);ylim([-15 15]);zlim([-15 15]);
legend('"Real source"','"Estimated source"', '"Microphone 1"', '"Microphone 2"','"Microphone 3"','"Microphone 4"');
plot3(X,Y,Z);hold on;
plot3(X1,Y1,Z1); hold on;
plot3(X2,Y2,Z2); hold on;
plot3(X3,Y3,Z3);
grid on; hold off;
grid on; hold off;
%if metoda == 'Spectrograma'
 %   saveas(h, 'Rezultate_spectrograma.jpg' ,'jpeg')
%elseif metoda == 'Cross-corelatia'
 %   saveas(h, 'Rezultate_cross-corelatia.jpg' ,'jpeg')
%elseif metoda == 'RPA'
% %   saveas(h, 'Rezultate_RPA.jpg' ,'jpeg')
%elseif metoda == 'Transformata Wavelet'
 %   saveas(h, 'Rezultate_transformata_wavelet.jpg' ,'jpeg')
%end


h=figure
%title('Pozitionarea microfoanelor si a sursei de sunet');
scatter3(x_real,y_real,z_real,100,'magenta','s','filled'); 
hold on;
scatter3(xs,ys,zs,100,'red','s','filled'); 
hold on;
scatter3(x1,y1,z1,100,'blue','h','filled'); 
hold on;
scatter3(x2,y2,z2,100,'green','h','filled'); 
hold on;
scatter3(x3,y3,z3,100,'yellow','h','filled'); 
hold on;
scatter3(x4,y4,z4,100,'black','h','filled'); 
hold on;
xlabel('x-axis');ylabel('y-axis'); zlabel('z-axis');
xlim([0 12]);ylim([0 12]);zlim([0 12]);
legend('"Real source"','"Estimated source"', '"Microphone 1"', '"Microphone 2"','"Microphone 3"','"Microphone 4"');
plot3(X,Y,Z);hold on;
plot3(X1,Y1,Z1); hold on;
plot3(X2,Y2,Z2); hold on;
plot3(X3,Y3,Z3);
view(30,60);
grid on; hold off;

%saveas(h, 'Rezultate.jpg' ,'jpeg')
end


