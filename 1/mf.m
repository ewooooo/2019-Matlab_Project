N = 1;     #N�� 1���� ����
A=1; T=2; r=0.5; t= -3:0.01:3; w0 = pi;  #���� ����

for c=1:5
  xr = 0; #DC ����
  for k=1:N
   xr = xr + (8*A/pi^2)*( 1/((2*k-1)^2) * cos((2*k-1)*w0*t -((-1)^(k-1))*pi/2)); #������ ���� ���ϱ�.
  end     #���Ĵ�Ī �� ���Ī�̹Ƿ� Ȧ���� sin�׸� ����.
  if N == 1
    subplot(511),plot(t,xr),title('x_r(t) N=1');  #�׷��� ���
  elseif N == 4
    subplot(512),plot(t,xr),title('x_r(t) N=4');
  elseif N == 7
    subplot(513),plot(t,xr),title('x_r(t) N=7');
  else
    subplot(514),plot(t,xr),title('x_r(t) N=10');

end
  xlabel('t');
  N = N+3;
end

N = 20;
xr = 0;
for k=1:N
 xr = xr + (8*A/pi^2)*( 1/((2*k-1)^2) * cos((2*k-1)*w0*t -((-1)^(k-1))*pi/2)); #������ ���� ���ϱ�.
end
subplot(515),plot(t,xr),title('x_r(t) N=20');