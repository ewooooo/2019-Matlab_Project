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

#반송파 c(t)
fc = 125;
c = cos(2*pi*fc*t);

#변조 신호 s(t)
s = c.*m;
S = abs(fft(s));
shiftS = fftshift(S);

#2번
#분산 N 구하기  
avg_s = mean(s.^2); #s(t) 샘플 평균
N = [avg_s avg_s/10^2 avg_s/10^4];

#LPF 만들기
f_cut = 125;
n_cut = floor(f_cut/df);
H = zeros(size(Freq));
H(1:n_cut) = 2*ones(1,n_cut);
H(length(Freq)-n_cut+1 : length(Freq)) = 2*ones(1,n_cut);
shiftH = fftshift(H);

#LPF
  subplot(7,1,4), plot(Freq,shiftH),title('LPF H(f)'),
  xlabel('Freq(kHz)'),ylabel('Amplitude Sqectrum'),grid on;

for i = 1 : 3
  a=sqrt(N(i)); b =0; #a 표준편차<-분산 b 평균
  n = a.*randn(1,length(s)) + b; #평균 0 분산 N인 
  x = s + n;

  #x(t) 진폭스펙트럽
  X = abs(fft(x));  shiftX = fftshift(X);
    
  #복조 
  sc = x.*c;
  SC = abs(fft(sc));  shiftSC = fftshift(SC);

  #LPF 적용
  Z = H.*SC;  shiftZ = fftshift(Z);
  
  #복조된 메시지 신호
  z = ifft(Z);  shiftz= fftshift(z);
  
  #n(t) 잡음신호
  subplot(7,3,i), plot(t,n),title('n(t)'),
  xlabel('Time (s)'),ylabel('Amplitude'), grid on;
  #x(t) 잡음 더해진 신호
  subplot(7,3,3+i), plot(t,x),title('x(t) = s(t)+n(t)'),
  xlabel('Time (s)'),ylabel('Amplitude'),  grid on;
  #X(f)*C(f)
  subplot(7,3,6+i), plot(Freq,shiftX),title('X(f)'),
  xlabel('Freq(Hz)'),ylabel('Amplitude Sqectrum'),grid on;
  
  #복조
  #X(f)*C(f)
  subplot(7,3,12+i), plot(Freq,shiftSC),title('fft(x(t)*c(t))'),
  xlabel('Freq(Hz)'),ylabel('Amplitude Sqectrum'),grid on;
  #LPF 적용 Z(f)
  subplot(7,3,15+i), plot(Freq,shiftZ),title('Z(f) (LPF after)'),
  xlabel('Freq (Hz)'),ylabel('Amplitude Sqectrum'),grid on;
  #ifft x(t) = m(t)
  subplot(7,3,18+i), plot(t,shiftz),title('ifft(Z(f))'),
  xlabel('Time (s)'),ylabel('Amplitude'), grid on;
end

  


