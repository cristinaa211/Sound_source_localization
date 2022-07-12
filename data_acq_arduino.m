clear all
close all
delete(instrfind)
arduino=serial('COM6');
set(arduino,'BaudRate',115200);
fopen(arduino);
i=1;
tic
     while 1<2
        data = fscanf(arduino);
        if real(str2double(data)) < 5 & real(str2double(data)) > 2
            a2=toc;
            for j=1:1000
               data = fscanf(arduino);
                y(i+j)= real(str2double(data));
            end    
            break
        end
        y(i)= real(str2double(data));
         i=i+1;
     end

Fs=length(y)/a2/4;
fclose(arduino);
delete(instrfind);
[a,b]=size(y);
j=1;
if b > 16000
    for i=b-16000:4:b-3
         s1(j)=y(i);
         s2(j)=y(i+1);
         s3(j)=y(i+2);
         s4(j)=y(i+3);
         j=j+1;
    end
end
if b < 16000
        for i=1:4:b-3
            s1(j)=y(i);
            s2(j)=y(i+1);
            s3(j)=y(i+2);
            s4(j)=y(i+3);
            j=j+1;
        end
end

%s111=doFilter(s11);s222=doFilter(s12);s333=doFilter(s13);s444=doFilter(s14);
%s1s=doFilterh(s111);s2s=doFilterh(s222);s3s=doFilterh(s333);s4s=doFilterh(s444);
f=2;
prag=0.4;
%s1=interp(s1s,f);
%s2=interp(s2s,f);
%s3=interp(s3s,f);
%s4=interp(s4s,f);
x1=0;       y1=0;       z1=0;
x2=-0.60;   y2=0.73;    z2=0.15;
x3=0.6;     y3=0.65;    z3=0;
x4=-1;      y4=0.73;    z4=0.26;
fid0=fopen('fs.txt','w');
b0=fprintf(fid0,'%d',Fs);
fclose(fid0)
fid=fopen('s1.txt','w');
b1=fprintf(fid,'%.15f\n',s1(10:end));
fclose(fid)
fid1=fopen('s2.txt','w');
b2=fprintf(fid1,'%.15f\n',s2(10:end));
fclose(fid1);
fid2=fopen('s3.txt','w');
b3=fprintf(fid2,'%.15f\n',s3(10:end));
fclose(fid2);
fid3=fopen('s4.txt','w');
b4=fprintf(fid3,'%.15f\n',s4(10:end));
fclose(fid3);
fid=fopen('coordonate_x.txt','w');
b1=fprintf(fid,'%.15f\n',x1,x2,x3,x4);
fclose(fid);
fid=fopen('coordonate_y.txt','w');
b1=fprintf(fid,'%.15f\n',y1,y2,y3,y4);
fclose(fid);
fid=fopen('coordonate_z.txt','w');
b1=fprintf(fid,'%.15f\n',z1,z2,z3,z4);
fclose(fid);


semnale_timp(s1,s2,s3,s4, Fs);
[tdoa12_cr , tdoa13_cr, tdoa14_cr] = corelatia(s1,s2,s3,s4,Fs);
%[tdoa12_sp,tdoa13_sp,tdoa14_sp]= spectrograma_s(s1,s2,s3,s4,Fs,prag);
%[tdoa12_wave,tdoa13_wave,tdoa14_wave]=wavelet_s(s1,s2,s3,s4,Fs,prag);
%[tdoa12_rpa,tdoa13_rpa,tdoa14_rpa]=rpa(s1,s2,s3,s4,Fs,prag);

[tdoa12_dpe,tdoa13_dpe,tdoa14_dpe]=dpe(s1,s2,s3,s4,Fs);
[xs_dpe,ys_dpe,zs_dpe]=tdoa_sigur_timpreal(tdoa12_dpe,tdoa13_dpe,tdoa14_dpe,x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4)

[xs_cor,ys_cor,zs_cor]=tdoa_sigur_timpreal(tdoa12_cr,tdoa13_cr,tdoa14_cr,x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4)
%[xs_sp,ys_sp,zs_sp]=tdoa_sigur_timpreal(tdoa12_sp,tdoa13_sp,tdoa14_sp,x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4);
%[xs_wav,ys_wav,zs_wav]=tdoa_sigur_timpreal(tdoa12_wave,tdoa13_wave,tdoa14_wave,x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4);
%[xs_rpa,ys_rpa,zs_rpa]=tdoa_sigur_timpreal(tdoa12_rpa,tdoa13_rpa,tdoa14_rpa,x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4)


%%Tabel cu rezultate

%A=["Cross-corelatia",xs_cor,ys_cor,zs_cor];
%B=["RPA",xs_rpa,ys_rpa,zs_rpa];
%C=["Transformata wavelet",xs_wav,ys_wav,zs_wav];
%D=["Spectrograma",xs_sp,ys_sp,zs_sp];
%A1=["Cross-corelatia",tdoa12_cr,tdoa13_cr,tdoa14_cr];
%B1=["RPA",tdoa12_rpa,tdoa13_rpa,tdoa14_rpa];
%C1=["Transformata wavelet",tdoa12_wave,tdoa13_wave,tdoa14_wave];
%D1=["Spectrograma",tdoa12_sp,tdoa13_sp,tdoa14_sp];
%R=[A;B;C;D];
%R1=[A1;B1;C1;D1];

%Trimitere Alarma

A11=[xs_dpe,ys_dpe,zs_dpe];
fileID = fopen('coordonate_sursa.txt','w');
fprintf(fileID, 'S-a detectat o sursa acustica la coordonatele:\n');
fprintf(fileID,'%6s %12s %16s\r\n','x','y','z');
fprintf(fileID,'%6.2f %12.8f %16.2f\r\n',A11);
type coordonate_sursa.txt;
%T=array2table(R,'VariableNames',{'Metoda','x','y','z'})
%T1=array2table(R1,'VariableNames',{'Metoda','td12','td13','td14'});
send_email('cristina.popovici211@gmail.com','Sursa acustica detectata','S-a detectat o sursa acustica',{});
if xs_dpe~=0 && ys_dpe~=0 && zs_dpe~=0
    send_email('cristina.popovici211@gmail.com','Sursa acustica detectata','S-a detectat o sursa acustica, deschideti fisierul pentru a viziona coordonatele:',{'C:\Users\Teo\Desktop\Licenta_2020\MATLAB\Coduri Matlab\coordonate_sursa.txt','C:\Users\Teo\Desktop\Licenta_2020\MATLAB\Coduri Matlab\Rezultate.jpg'});
end