function [tdoa12_dpe,tdoa13_dpe,tdoa14_dpe]=dpe(s1,s2,s3,s4,Fs)
level=0.35;
n1=find(abs(s1(5:end)-1.4)>level,1,'first');
n2=find(abs(s2(5:end)-1.4)>level,1,'first');
n3=find(abs(s3(5:end)-1.4)>level,1,'first');
n4=find(abs(s4(5:end)-1.4)>level,1,'first');
tdoa12_dpe=(n1-n2)/Fs;
tdoa13_dpe=(n1-n3)/Fs;
tdoa14_dpe=(n1-n4)/Fs;
end