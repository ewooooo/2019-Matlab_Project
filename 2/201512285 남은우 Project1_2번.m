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

#�ݼ��� c(t)
fc = 125;
c = cos(2*pi*fc*t);

#���� ��ȣ s(t)
s = c.*m;
S = abs(fft(s));
shiftS = fftshift(S);

#2��
#�л� N ���ϱ�  
avg_s = mean(s.^2); #s(t) ���� ���
N = [avg_s avg_s/10^2 avg_s/10^4];

#LPF �����
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
  a=sqrt(N(i)); b =0; #a ǥ������<-�л� b ���
  n = a.*randn(1,length(s)) + b; #��� 0 �л� N�� 
  x = s + n;

  #x(t) ��������Ʈ��
  X = abs(fft(x));  shiftX = fftshift(X);
    
  #���� 
  sc = x.*c;
  SC = abs(fft(sc));  shiftSC = fftshift(SC);

  #LPF ����
  Z = H.*SC;  shiftZ = fftshift(Z);
  
  #������ �޽��� ��ȣ
  z = ifft(Z);  shiftz= fftshift(z);
  
  #n(t) ������ȣ
  subplot(7,3,i), plot(t,n),title('n(t)'),
  xlabel('Time (s)'),ylabel('Amplitude'), grid on;
  #x(t) ���� ������ ��ȣ
  subplot(7,3,3+i), plot(t,x),title('x(t) = s(t)+n(t)'),
  xlabel('Time (s)'),ylabel('Amplitude'),  grid on;
  #X(f)*C(f)
  subplot(7,3,6+i), plot(Freq,shiftX),title('X(f)'),
  xlabel('Freq(Hz)'),ylabel('Amplitude Sqectrum'),grid on;
  
  #����
  #X(f)*C(f)
  subplot(7,3,12+i), plot(Freq,shiftSC),title('fft(x(t)*c(t))'),
  xlabel('Freq(Hz)'),ylabel('Amplitude Sqectrum'),grid on;
  #LPF ���� Z(f)
  subplot(7,3,15+i), plot(Freq,shiftZ),title('Z(f) (LPF after)'),
  xlabel('Freq (Hz)'),ylabel('Amplitude Sqectrum'),grid on;
  #ifft x(t) = m(t)
  subplot(7,3,18+i), plot(t,shiftz),title('ifft(Z(f))'),
  xlabel('Time (s)'),ylabel('Amplitude'), grid on;
end

  


