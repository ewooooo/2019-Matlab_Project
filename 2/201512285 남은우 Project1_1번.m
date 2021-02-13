#1번 변조 내용
dt = 0.001;       #시간영역 샘플링 간격
t = -0.1:dt:0.1;  #시간영역 샘플링 구간
f_s = 1/dt;       #시간영역 샘플링 주파수

#메시지 신호 m(t)
m = ((1/0.05)*t + 1).*((t>=-0.05)-(t>=0)) + (-(1/0.05)*t + 1).*((t>=0)-(t>=0.05));

#푸리의 변환
M = abs(fft(m));              #fft 변환 후 절대값      
shiftM = fftshift(M);      #중심으로 가져오기

#Freq 설정
n = length(M);                #fft 표본 개수 (201개)  
df = f_s / n;                 #주파수영역 샘플링 간격
Freq = (0:n-1)*(df)-f_s/2; #주파수영역 샘플링 구간

#m(t) plot
subplot(4,1,1), plot(t,m),title('m(t)'),
xlabel('Time (s)'),ylabel('Amplitude'), grid on;

#M(f) plot
subplot(4,1,2), plot(Freq,shiftM/f_s),title('M(f)'),
xlabel('Freq(Hz)'),ylabel('Amplitude Sqectrum'),grid on;

#반송파 c(t)
fc = 125;
c = cos(2*pi*fc*t);

#변조 신호 s(t)
s = c.*m;
S = abs(fft(s));
shiftS = fftshift(S);

#s(t) plot
subplot(4,1,3), plot(t,s),title('s(t)'),
xlabel('Time (s)'),ylabel('Amplitude'), grid on;

#S(f) plot
subplot(4,1,4), plot(Freq,shiftS/f_s),title('S(f)'),
xlabel('Freq(Hz)'),ylabel('Amplitude Sqectrum'),grid on;