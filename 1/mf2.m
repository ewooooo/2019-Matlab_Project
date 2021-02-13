N = 10;     #N�� 10���� ����
A=1; T=2; r=0.5; t= -3:0.01:3; w0 = pi;  #���� ����

for c=1:3
  xr = (2*A*r/T)*ones(1,length(t)); #DC ����
  for k=1:N
   xr=xr+ (4*A*r)/T*(sinc(2*k*r/T)*cos(k*w0*t)); # k��° �����ĸ� ��.
  end
  if N == 10
    subplot(411),plot(t,xr),title('x_r(t) N=10'); # �׷��� ���
  elseif N == 20
    subplot(412),plot(t,xr),title('x_r(t) N=20');
  else
    subplot(413),plot(t,xr),title('x_r(t) N=30');
  end
  xlabel('t');
  N = N+10;
end

N = 100;
xr = (2*A*r/T)*ones(1,length(t)); #DC ����
for k=1:N
  xr=xr+ (4*A*r)/T*(sinc(2*k*r/T)*cos(k*w0*t)); # k��° �����ĸ� ��.
end
  subplot(414),plot(t,xr),title('x_r(t) N=100');