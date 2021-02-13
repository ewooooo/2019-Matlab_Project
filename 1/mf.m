N = 1;     #N은 1부터 증가
A=1; T=2; r=0.5; t= -3:0.01:3; w0 = pi;  #사전 설정

for c=1:5
  xr = 0; #DC 성분
  for k=1:N
   xr = xr + (8*A/pi^2)*( 1/((2*k-1)^2) * cos((2*k-1)*w0*t -((-1)^(k-1))*pi/2)); #고조파 성분 합하기.
  end     #반파대칭 및 기대칭이므로 홀수의 sin항만 남음.
  if N == 1
    subplot(511),plot(t,xr),title('x_r(t) N=1');  #그래프 출력
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
 xr = xr + (8*A/pi^2)*( 1/((2*k-1)^2) * cos((2*k-1)*w0*t -((-1)^(k-1))*pi/2)); #고조파 성분 합하기.
end
subplot(515),plot(t,xr),title('x_r(t) N=20');