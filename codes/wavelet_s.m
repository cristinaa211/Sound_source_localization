function [tdoa12_wave,tdoa13_wave,tdoa14_wave]=wavelet_s(s1,s2,s3,s4,Fs,prag)

    a0 = 2^(1/64);
    scales = a0.^(1*64:4*64);
    figure
    [cfs1,sc1] = cwt(s1,scales,'haar',1/Fs,'scal');
    xlabel ('Samples'), ylabel('Scale'); title('Scalogram 1');
    figure
     [cfs2,sc2] = cwt(s2,scales,'haar',1/Fs,'scal');
    xlabel ('Samples'), ylabel('Scale'); title('Scalogram 2');
    figure
     [cfs3,sc3] = cwt(s3,scales,'haar',1/Fs,'scal');
    xlabel ('Samples'), ylabel('Scale'); title('Scalogram 3');
    figure
     [cfs4,sc4] = cwt(s4,scales,'haar',1/Fs,'scal');
    xlabel ('Samples'), ylabel('Scale'); title('Scalogram 4');
    
    
    
    figure

subplot(2,2,1);plot(sum(abs(cfs1)));axis tight; title('Detection curve 1');grid on;xlabel('Samples');ylabel('Amplitude');
subplot(2,2,2);plot(sum(abs(cfs2)));axis tight;title('Detection curve 2'); grid on;xlabel('Samples');ylabel('Amplitude');
subplot(2,2,3);plot(sum(abs(cfs3)));axis tight;title('Detection curve 3'); grid on;xlabel('Samples');ylabel('Amplitude');
subplot(2,2,4);plot(sum(abs(cfs4)));axis tight;title('Detection curve 4'); grid on;xlabel('Samples');ylabel('Amplitude');



[val1,tt1]=max(sum(abs(cfs1)));
[val2,tt2]=max(sum(abs(cfs2)));
[val3,tt3]=max(sum(abs(cfs3)));
[val4,tt4]=max(sum(abs(cfs4)));


I1=find(sum(abs(cfs1))>prag*val1,1);
I2=find(sum(abs(cfs2))>prag*val2,1);
I3=find(sum(abs(cfs3))>prag*val3,1);
I4=find(sum(abs(cfs4))>prag*val4,1);
    

n1=max(I1)/Fs;
n2=max(I2)/Fs;
n3=max(I3)/Fs;
n4=max(I4)/Fs;

tdoa12_wave=n1-n2;
tdoa13_wave=n1-n3;
tdoa14_wave=n1-n4;
      
      
    