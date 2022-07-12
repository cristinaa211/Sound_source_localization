function [tdoa12_rpa,tdoa13_rpa,tdoa14_rpa]=rpa(s1,s2,s3,s4,Fs,prag)

t=0:1/Fs:length(s1);

figure ;title('State space')
subplot(2,2,1)
phasespace(s1,3,1); title('State space 1 '); 
subplot(2,2,2)
phasespace(s2,3,1);title('State space  2');
subplot(2,2,3)
phasespace(s3,3,1);title('State space  3');
subplot(2,2,4)
phasespace(s4,3,1); title('State space  4');


[RP1,DD1]= RPplot(s1,3,1,0.9,0);
figure
subplot(2,2,1)
imagesc(t,t,DD1)
axis square
title('Distance matrix 1'); xlabel('Time'); ylabel('Time');axis tight;
subplot(2,2,2)
imagesc(t,t,RP1)
axis square
title('Recurrence matrix 1');
xlabel('Time'); ylabel('Time');axis tight;


[RP2,DD2]= RPplot(s2,3,1,0.9,0);
subplot(2,2,3)
imagesc(t,t,DD2)
axis square
title('Distance matrix 2'); xlabel('Time'); ylabel('Time');axis tight;

subplot(2,2,4)
imagesc(t,t,RP2)
axis square
title('Recurrence matrix 2');
xlabel('Time'); ylabel('Time');axis tight;



[RP3,DD3]= RPplot(s3,3,1,0.9,0);
figure
subplot(2,2,1)
imagesc(t,t,DD3)
axis square
title('Distance matrix 3'); xlabel('Time'); ylabel('Time');axis tight;

subplot(2,2,2)
imagesc(t,t,RP3)
axis square
title('Recurrence matrix 3');
xlabel('Time'); ylabel('Time');axis tight;

[RP4,DD4]= RPplot(s4,3,1,0.9,0);
subplot(2,2,3)
imagesc(t,t,DD4)
axis square
title('Distance matrix 4'); xlabel('Time'); ylabel('Time');axis tight;

subplot(2,2,4)
imagesc(t,t,RP4)
axis square
title('Recurrence matrix 4');
xlabel('Time'); ylabel('Time');axis tight;


[a,b]=size(DD1);
C1=zeros(1,b);C2=zeros(1,b);
C3=zeros(1,b);C4=zeros(1,b);

   for j=1:b
          C1(j) = sum(DD1(:,j));
        
          C2(j) = sum(DD2(:,j));
         
          C3(j) = sum(DD3(:,j));
        
          C4(j) = sum(DD4(:,j));
         
          
   end
   

[val1,tt1]=max(C1);
[val2,tt2]=max(C2);
[val3,tt3]=max(C3);
[val4,tt4]=max(C4);


I1=find(C1>prag*val1,1,'first');
I2=find(C2>prag*val2,1,'first');
I3=find(C3>prag*val3,1,'first');
I4=find(C4>prag*val4,1,'first');
    

n1=I1/Fs;
n2=I2/Fs;
n3=I3/Fs;
n4=I4/Fs;

tdoa12_rpa=n1-n2;
tdoa13_rpa=n1-n3;
tdoa14_rpa=n1-n4;
      
      
figure

subplot(2,2,1);plot(C1); grid on; title('Detection curve 1'); xlabel('Samples'); ylabel('Amplitude');axis tight;
subplot(2,2,2);plot(C2);title('Detection curve 2'); grid on;xlabel('Samples'); ylabel('Amplitude');axis tight;
subplot(2,2,3);plot(C3);title('Detection curve 3'); grid on;xlabel('Samples'); ylabel('Amplitude');axis tight;
subplot(2,2,4);plot(C4);title('Detection curve 4'); grid on;xlabel('Samples'); ylabel('Amplitude');axis tight;
end


