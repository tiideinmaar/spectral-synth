function [a,harmfreq,harmpow] = reSynth2(fileName,numHarm)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fileExt = '.wav';
fileSuf = '_Synth2';
wavIn = strcat(fileName,fileExt);
wavOut = strcat(fileName,fileSuf,fileExt);

[x,Fs] = audioread(wavIn);

y = fft(x);
T = 1/Fs;
L = length(x);
t = (0:L-1)*T;
P2 = abs(y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(1);
plot(t,x);
title(['Waveform of ' fileName]);
axis([0 .1 -.2 .2]);
figure(2);
plot(f,P1);
title(['Frequency-Domain Spectrum of ' fileName]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
axis([0 1000 0 .1]);
figure(3);
[harmpow,harmNo] = findpeaks(P1,'Threshold',.001,'NPeaks',numHarm);
harmfreq = NaN(size(harmNo));
hCyc = 1;
while hCyc <= length(harmNo)
    harmfreq(hCyc,1) = f(1,harmNo(hCyc,1));
    hCyc = hCyc + 1;
end
plot(harmfreq,harmpow);
title(['Analysed Peak Frequency-Domain Amplitudes of ' fileName]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
axis([0 1000 0 .1]);

a = [harmpow,harmfreq];
t = linspace(0,1,Fs);
wavVar = a(1,1)*sin(2*pi*a(1,2)*t);
m1 = 2;
while m1 <= length(a)
    h = a(m1,1)*sin(2*pi*a(m1,2)*t);
    wavVar = wavVar + h;
    m1 = m1 + 1;
end
audiowrite(wavOut,wavVar,Fs);
specPlotInt(fileName,numHarm);
end