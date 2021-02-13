pkg load signal
clear;
%1번
ts = 0.001;       %시간영역 샘플링 간격
t = -0.25:ts:0.25;  %시간영역 샘플링 구간
f_s = 1/ts;       %시간영역 샘플링 주파수

Ac = 100; %반송파 진폭
fc = 300; %반송파 주파수

beta = [0.5 1.0 10.0 100.0]; % B 베타값 4가지

%메시지 신호 m(t)
m = 5*cos(2*pi*8*t);
Am = 5;
fm = 8;

% m(t) plot
plot(t,m),title('m(t)'),
xlabel('Time (s)'),ylabel('Amplitude'), grid on;

%적분 m(t)
ns = length(t);
integ_m(1,1) = 0;
for i=1:ns-1
  integ_m(1,i+1) = integ_m(1,i) + m(1,i)*ts;
endfor


for a = 1:4
  # fm 변호 s(t)
  Kf = beta(a)*fm/Am;   %B = Kf*Am/fm
 
  s = Ac*cos(2*pi*fc*t.+(2*pi*Kf)*integ_m);
  %s = Ac*cos(2*pi*fc*t+beta(a)*sin(2*pi*fm*t));

  S = abs(fft(s));            %fft 변환 후 절대값      
  shiftS = fftshift(S)*ts;     %중심으로 가져오기
  angS = angle(fftshift(fft(s))); 

%Freq 설정
  n = length(S);                %fft 표본 개수 (201개)  
  df = f_s / n;                 %주파수영역 샘플링 간격
  Freq = (0:n-1)*(df)-f_s/2; %주파수영역 샘플링 구간
  figure();
  
%s(t) plot
  subplot(4,1,1), plot(t,s),title('s(t)'),
  xlabel('Time (s)'),ylabel('Amplitude'), grid on;
%S(f) plot
  subplot(4,1,2), plot(Freq,shiftS),title('S(f)'),
  xlabel('Freq(Hz)'),ylabel('Amplitude Sqectrum'),grid on;
%argS(f) plot
  subplot(4,1,3), plot(Freq,angS),title('argS(f)'),
  xlabel('Freq(Hz)'),ylabel('Amplitude Sqectrum'),grid on;
  
% 복조
  y = unwrap(angle(hilbert(s).*exp(-j*2*pi*fc*t)));

  result_m(1,1)=0;
  for b=1:(length(t)-1)
    result_m(1,b) = (y(1,b+1) - y(1,b))/ts;
  endfor
  result_m(1,length(t)) = 0;
  
  result_m = (1/(2*pi*Kf)).*result_m;
  %result_m(t) plot
  subplot(4,1,4), plot(t,result_m),title('result_m(t)'),
  xlabel('Time (s)'),ylabel('Amplitude'), grid on;

endfor

