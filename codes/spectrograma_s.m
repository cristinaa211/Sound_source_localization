function [tdoa_sp12,tdoa_sp13,tdoa_sp14]=spectrograma_s(s1,s2,s3,s4,Fs,prag)

figure
subplot(2,2,1)
spectrogram(s1,128,50,128,Fs,'yaxis'); axis tight;title('Spectrogram 1');
subplot(2,2,2)
spectrogram(s2,128,50,128,Fs,'yaxis');axis tight;title('Spectrogram 2');
subplot(2,2,3)
spectrogram(s3,128,50,128,Fs,'yaxis');axis tight;title('Spectrogram 3');
subplot(2,2,4)
spectrogram(s4,128,50,128,Fs,'yaxis'); axis tight;title('Spectrogram 4');


[S1] = spectrogram(s1,32,16,512,Fs,'yaxis'); 
[S2] = spectrogram(s2,32,16,512,Fs,'yaxis');
[S3] = spectrogram(s3,32,16,512,Fs,'yaxis');
[S4] = spectrogram(s4,32,16,512,Fs,'yaxis');


    figure

subplot(2,2,1);plot(sum(abs(S1))); axis tight;grid on; xlabel('Samples');ylabel('Amplitude');title('Detection curve 1');
subplot(2,2,2);plot(sum(abs(S2)));axis tight; grid on;xlabel('Samples');ylabel('Amplitude');title('Detection curve 2');
subplot(2,2,3);plot(sum(abs(S3)));axis tight; grid on;xlabel('Samples');ylabel('Amplitude');title('Detection curve 3');
subplot(2,2,4);plot(sum(abs(S4)));axis tight; grid on;xlabel('Samples');ylabel('Amplitude');title('Detection curve 4');

nr=length(s1)/length(S1);
[val1,tt1]=max(sum(abs(S1)));
[val2,tt2]=max(sum(abs(S2)));
[val3,tt3]=max(sum(abs(S3)));
[val4,tt4]=max(sum(abs(S4)));


I1=find(sum(abs(S1))>prag*val1,1);
I2=find(sum(abs(S2))>prag*val2,1);
I3=find(sum(abs(S3))>prag*val3,1);
I4=find(sum(abs(S4))>prag*val4,1);
    

n1=nr*I1/Fs;
n2=nr*I2/Fs;
n3=nr*I3/Fs;
n4=nr*I4/Fs;

tdoa_sp12=n1-n2;
tdoa_sp13=n1-n3;
tdoa_sp14=n1-n4;




