% Static force analysis of tensegrity structure:Michell Truss of order 4
% reffered to Bob's book, Figure 4.6 and code TBar.m provided by Bewley.
clear; clf; figure(1);
phi = pi/16;
beta = pi/6; 
a = sin(beta)/sin(beta + phi);
c = sin(phi)/sin(beta + phi);
r=zeros(1,5);
comp = i;
r(1)=5;
for i=2:5
    r(i)=a*r(i-1);
end
% Free [Q=Q_(dim x q)] and fixed [P=P_(dim x q)] node locations
Q(:,1)=[r(1); 0];
Q(:,2)=[real(r(2)*exp((-phi)*comp));imag(r(2)*exp((-phi*comp)))];
Q(:,3)=[real(r(2)*exp((phi)*comp));imag(r(2)*exp((phi*comp)))];
for i = 1:3
   Q(:,i+3) =[real(r(3)*exp((phi*(2*i-4))*comp));imag(r(3)*exp((phi*(2*i-4))*comp))] ;
end
for i = 1:4
   Q(:,i+6) =[real(r(4)*exp((phi*(2*i-5))*comp));imag(r(4)*exp((phi*(2*i-5))*comp))] ;
end
[dim,q]=size(Q);
for i = 1:5
   P(:,i) =[real(r(5)*exp((phi*(2*i-6))*comp));imag(r(5)*exp((phi*(2*i-6))*comp))] ;
end
p=size(P,2); n=q+p;
% Connectivity matrix, in this situation, all bars.
C(  1,1)=1; C(  1,2)=-1; 
C(  2,1)=1; C(  2,3)=-1; 
C(  3,2)=1; C(  3,4)=-1; 
C(  4,2)=1; C(  4,5)=-1; 
C(  5,3)=1; C(  5,5)=-1; 
C(  6,3)=1; C(  6,6)=-1; 
C(  7,4)=1; C(  7,7)=-1; 
C(  8,4)=1; C(  8,8)=-1; 
C(  9,5)=1; C(  9,8)=-1; 
C(  10,5)=1; C(  10,9)=-1; 
C(  11,6)=1; C(  11,9)=-1; 
C(  12,6)=1; C(  12,10)=-1; 
k=13;
for i=1:4
    for j = 1:2
        C(k,i+6) = 1;C(  k,i+9+j)=-1; 
        k=k+1;
    end
end
b = k-1; s = 0;m=b+s;
U(1:dim,1:10)=0;
theta = pi/2;
switch theta 
    case pi/6
        U(1,1) = 3; U(2,1) = sqrt(3);
    case pi/2
        U(2,1) = 3;
    case -pi/2
        U(2,1) = -3;
    case 0
        U(1,1) = 3;
    otherwise 
        U(1,1) = -3;
end
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,2.0); grid on;