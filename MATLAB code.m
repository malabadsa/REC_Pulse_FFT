clear all; close all; clc;

A = 1;
tau = 25;   %ps
T = 1024;   %FFT window size (ps)
N = 2048;   % number of sampling

dt = T/N;   %time interval
df = 1/T;   %frequency interval

t = -T/2 : dt : T/2-dt; %time vector    
f=-N*df/2 : df : N*df/2-df; %frequency vector

vt = A * (abs(t) < tau/2);  %Rectangular Pulse
Vf = fftshift(fft(vt));     %Fourier transform of Rect. Pulse

%Plot Rect Pulse
figure('Position',[100 100 800 300])
subplot(121)
plot(t,abs(vt).^2)
grid on;
ylim([0 1.3])
xlim([-400 400])
title('|v(t)|^2')
xlabel('T[Ps]')
ylabel('P[mW]')

%Plot PSD
subplot(122)
plot(f, 10*log10(abs(Vf).^2/N*dt))
grid on;
ylim([-40 0])
xlim([-0.5 0.5])
title('S(f)')
xlabel('f[THz]')
ylabel('PSD')

% check Parcevals theorem
Pave_t = mean(abs(vt).^2);
Pave_f = sum(abs(Vf).^2/N*dt*df);
% Pave_t = Pave_f = 0.0239