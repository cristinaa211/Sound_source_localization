function [t12cr,t13cr,t14cr]=corelatia(s,s1,s2,s3,Fs)

t=0:1/Fs:6;
s=s(5:end);
s1=s1(5:end);
s2=s2(5:end);
s3=s3(5:end);
[acor,lag] = xcorr(s,s1);
    [~,I] = max(abs(acor));
    timeDiff = lag(I)       ;  
    figure
    subplot(311); plot(s(10:end));axis tight; title('Signal 1');xlabel('Samples');ylabel('Amplitude');
    subplot(312); plot(s1(10:end));axis tight; title('Signal 2');xlabel('Samples');ylabel('Amplitude');
    subplot(313); plot(lag,acor);axis tight;
    title('Cross-correlation');xlabel('Samples'); ylabel('Magnitude');
    a=finddelay(s,s1);
    t12cr=-1/Fs*a ;
 [acor1,lag1] = xcorr(s,s2);
    [~,I1] = max(abs(acor1));
    timeDiff1 = lag(I1)   ;      
    figure
    subplot(311); plot(s(10:end));title('Signal 1');xlabel('Samples');ylabel('Amplitude');axis tight; 
    subplot(312); plot(s2(10:end)); title('Signal 3');xlabel('Samples');ylabel('Amplitude');axis tight; 
    subplot(313); plot(lag,acor);axis tight;
    title('Cross-correlation '); xlabel('Samples'); ylabel('Magnitude');
    a1=finddelay(s,s2);
    t13cr=-1/Fs*a1 ;
   [acor2,lag2] = xcorr(s,s3);
    [~,I2] = max(abs(acor2));
    timeDiff2 = lag(I2)        ;
    figure
    subplot(311); plot(s(10:end)); title('Signal 1');xlabel('Samples');ylabel('Amplitude');axis tight; 
    subplot(312); plot(s3(10:end)); title('Signal 4');xlabel('Samples');ylabel('Amplitude');axis tight; 
    subplot(313); plot(lag,acor);axis tight
    title('Cross-correlation');xlabel('Samples'); ylabel('Magnitude');
    a2=finddelay(s,s3);
    t14cr=-1/Fs*a2 ;
end
