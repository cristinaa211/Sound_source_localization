function []=semnale_timp(s,s1,s2,s3,Fs)
t = (0:length(s)-1)/Fs;  %secunde
figure;title('Semnalele receptionate');
plot(t,s,t,s1,t,s2,t,s3); legend('Signal 1', 'Signal 2','Signal 3','Signal 4');
xlabel('Time (sec)');ylabel('Amplitude');
figure

subplot(2,2,1);plot(t,s); grid on; title('Signal 1'); xlabel('Time (sec)');ylabel('Amplitude');axis tight;
subplot(2,2,2);plot(t,s1);title('Signal 2'); grid on; xlabel('Time (sec)');ylabel('Amplitude');axis tight;
subplot(2,2,3);plot(t,s2);title('Signal 3'); grid on; xlabel('Time (sec)');ylabel('Amplitude');axis tight;
subplot(2,2,4);plot(t,s3);title('Signal 4'); grid on; xlabel('Time (sec)');ylabel('Amplitude');axis tight;
end