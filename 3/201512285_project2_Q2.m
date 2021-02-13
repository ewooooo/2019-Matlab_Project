pkg load signal
clear;
%2��
ts = 0.001;       %�ð����� ���ø� ����
t = -0.25:ts:0.25;  %�ð����� ���ø� ����
f_s = 1/ts;       %�ð����� ���ø� ���ļ�

Ac = 100; %�ݼ��� ����
fc = 300; %�ݼ��� ���ļ�

%�޽��� ��ȣ m(t)
m1 = 4*cos(2*pi*8*t);
m2 = 48*sin(2*pi*96*t);

m = m1 + m2;

beta = 2.0;

% m(t) plot
plot(t,m),title('m1(t)+ m2(t)'),
xlabel('Time (s)'),ylabel('Amplitude'), grid on;

# fm ��ȣ s(t)
Kf = beta*2  %B = Kf*Am/fm  => Kf = B*fm/Am

%���� m(t)
integ_m(1,1) = 0;
ns = length(t);
for i=1:ns-1
  integ_m(1,i+1) = integ_m(1,i) + m(1,i)*ts;
endfor

s = Ac*cos(2*pi*fc*t.+(2*pi*Kf)*integ_m);

S = abs(fft(s));            %fft ��ȯ �� ���밪      
shiftS = fftshift(S)*ts;     %�߽����� ��������
angS = angle(fftshift(fft(s))); 

%Freq ����
n = length(S);                %fft ǥ�� ���� (201��)  
df = f_s / n;                 %���ļ����� ���ø� ����
Freq = (0:n-1)*(df)-f_s/2; %���ļ����� ���ø� ����
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
  
% ����
y = unwrap(angle(hilbert(s) .*exp(-1i*2*pi*fc*t)));
  
result_m(1,1)=0;
for b=1:(length(t)-1)
  result_m(1,b) = (y(1,b+1) - y(1,b))/ts;
endfor
result_m(1,length(t)) = 0;

result_m = (1/(2*pi*Kf)).*result_m;

%result_m(t) plot
subplot(4,1,4), plot(t,result_m),title('result_m(t)'),
xlabel('Time (s)'),ylabel('Amplitude'), grid on;