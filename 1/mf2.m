N = 10;     #N은 10부터 증가
A=1; T=2; r=0.5; t= -3:0.01:3; w0 = pi;  #사전 설정

for c=1:3
  xr = (2*A*r/T)*ones(1,length(t)); #DC 성분
  for k=1:N
   xr=xr+ (4*A*r)/T*(sinc(2*k*r/T)*cos(k*w0*t)); # k번째 고조파를 합.
  end
  if N == 10
    subplot(411),plot(t,xr),title('x_r(t) N=10'); # 그래프 출력
  elseif N == 20
    subplot(412),plot(t,xr),title('x_r(t) N=20');
  else
    subplot(413),plot(t,xr),title('x_r(t) N=30');
  end
  xlabel('t');
  N = N+10;
end

N = 100;
xr = (2*A*r/T)*ones(1,length(t)); #DC 성분
for k=1:N
  xr=xr+ (4*A*r)/T*(sinc(2*k*r/T)*cos(k*w0*t)); # k번째 고조파를 합.
end
  subplot(414),plot(t,xr),title('x_r(t) N=100');