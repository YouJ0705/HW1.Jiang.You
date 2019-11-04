% Static force analysis of tensegrity structure:non minimal tensegrity prism with 4 bars
% similar to Bob's book, Figure 3.43 and code TBar3.m provided by Bewley.
clear; clf; figure(1);
Q(:,1)=[0; 0; 0];
Q(:,2)=[5; 0; 0];
Q(:,3)=[5; 5; 0];
Q(:,4)=[0; 5; 0];
Q(:,5)=[5; 3; 5];
Q(:,6)=[2; 5; 5];
Q(:,7)=[0; 2; 5];
Q(:,8)=[3; 0; 5];P=[];
[dim,q]=size(Q); p=size(P,2); n=q+p; 
% Connectivity matrix
for i = 1:4
    C(i,i) = 1; C(i,i+4) = -1;
end
b = 4;
C(b+1,1) = 1; C(b+1,2) = -1;
C(b+2,2) = 1; C(b+2,3) = -1;
C(b+3,3) = 1; C(b+3,4) = -1;
C(b+4,1) = 1; C(b+4,4) = -1;
C(b+5,5) = 1; C(b+5,6) = -1;
C(b+6,6) = 1; C(b+6,7) = -1;
C(b+7,7) = 1; C(b+7,8) = -1;
C(b+8,8) = 1; C(b+8,5) = -1;
C(b+9,1) = 1; C(b+9,8) = -1;
C(b+10,1) = 1; C(b+10,7) = -1;
C(b+11,2) = 1; C(b+11,8) = -1;
C(b+12,2) = 1; C(b+12,5) = -1;
C(b+13,3) = 1; C(b+13,5) = -1;
C(b+14,3) = 1; C(b+14,6) = -1;
C(b+15,4) = 1; C(b+15,6) = -1;
C(b+16,4) = 1; C(b+16,7) = -1;
s = 16 ; m=b+s;
U(1:dim,1:8)=0; 
U(3,5)=-5; U(3,6)=-5;U(3,7)=-5; U(3,8)=-5;
U(3,1)=5; U(3,2)=5;U(3,3)=5; U(3,4)=5;
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1,0.08); grid on;

