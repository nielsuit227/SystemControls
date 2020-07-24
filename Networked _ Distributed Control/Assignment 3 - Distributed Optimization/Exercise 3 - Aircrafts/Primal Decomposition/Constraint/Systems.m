% state vector is (x,y,xdot,ydot)
global A B X Tfinal umax
A1=[1 0 2 0; 0 1 0 2; 0 0 3 0; 0 0 0 3];
B1=[2 0;0 2;3 0;0 3];
x01=[-10;10;-1;1];

A2=[1 0 3 0; 0 1 0 3; 0 0 7 0; 0 0 0 7];
B2=[3 0; 0 3; 7 0; 0 7];
x02=[10;10;1;1];

A3=[1 0 1 0; 0 1 0 1; 0 0 1.1 0; 0 0 0 1.1];
B3=[1 0; 0 1; 1.1 0; 0 1.1];
x03=[10;-10;1;-1];

A4=[1 0 6 0; 0 1 0 6; 0 0 20 0; 0 0 0 20];
B4=[6 0;0 6;20 0; 0 20];
x04=[-10;-10;-1;-1];

A = zeros(4,4,4);
A(:,:,1) = A1;
A(:,:,2) = A2;
A(:,:,3) = A3;
A(:,:,4) = A4;

X = zeros(4,6,4);
X(:,1,1) = x01;
X(:,1,2) = x02;
X(:,1,3) = x03;
X(:,1,4) = x04;

B = zeros(4,2,4);
B(:,:,1) = B1;
B(:,:,2) = B2;
B(:,:,3) = B3;
B(:,:,4) = B4;

clear A1 A2 A3 A4 B1 B2 B3 B4 x01 x02 x03 x04



Tfinal=5;
umax=100;
