function [RP,DD] = RPplot(P,m,t,r,index)
% P: time series;
% m: the embedding dimension
% t: the delay time
% r: the threshold value 
% index: the value 0 or 1 (0 for Euclidean distance)
        


r = r*std(P);
if nargin < 4, error('Not enough input arguments'),end
N=length(P);
X=zeros(N-(m-1)*t,m);
for k=1:(N-(m-1)*t)
    PP=[];
    for i=1:m
        PP=[PP P(1,k-t+i*t)];
    end
    X(k,:)=PP;
end
N1=length(X);
DD=zeros(N1,N1);
if index == 0;
    r = r*r;
    for k1=1:N1 
       for k2=k1+1:N1
           DD(k1,k2) = sum( (X(k1,:) - X(k2,:)).^2 );
       end
     end
    DD=DD+DD';
end
RP=zeros(N1,N1);
for i=1:N1       
    for j=i+1:N1
        if DD(i,j) <= r
            RP(i,j)=1;
            RP(j,i)=1;
        end
    end
end
RP = RP +eye(N1);
