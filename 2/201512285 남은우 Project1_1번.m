#1�� ���� ����
dt = 0.001;       #�ð����� ���ø� ����
t = -0.1:dt:0.1;  #�ð����� ���ø� ����
f_s = 1/dt;       #�ð����� ���ø� ���ļ�

#�޽��� ��ȣ m(t)
m = ((1/0.05)*t + 1).*((t>=-0.05)-(t>=0)) + (-(1/0.05)*t + 1).*((t>=0)-(t>=0.05));

#Ǫ���� ��ȯ
M = abs(fft(m));              #fft ��ȯ �� ���밪      
shiftM = fftshift(M);      #�߽����� ��������

#Freq ����
n = length(M);                #fft ǥ�� ���� (201��)  
df = f_s / n;                 #���ļ����� ���ø� ����
Freq = (0:n-1)*(df)-f_s/2; #���ļ����� ���ø� ����

#m(t) plot
subplot(4,1,1), plot(t,m),title('m(t)'),
xlabel('Time (s)'),ylabel('Amplitude'), grid on;

#M(f) plot
subplot(4,1,2), plot(Freq,shiftM/f_s),title('M(f)'),
xlabel('Freq(Hz)'),ylabel('Amplitude Sqectrum'),grid on;

#�ݼ��� c(t)
fc = 125;
c = cos(2*pi*fc*t);

#���� ��ȣ s(t)
s = c.*m;
S = abs(fft(s));
shiftS = fftshift(S);

#s(t) plot
subplot(4,1,3), plot(t,s),title('s(t)'),
xlabel('Time (s)'),ylabel('Amplitude'), grid on;

#S(f) plot
subplot(4,1,4), plot(Freq,shiftS/f_s),title('S(f)'),
xlabel('Freq(Hz)'),ylabel('Amplitude Sqectrum'),grid on;