function [] = specPlotInt(fileName,numHarm)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fileExt = '.wav';
fileSuf = '_Synth2';
graphSuf = '\_Synth2';
wavIn = strcat(fileName,fileSuf,fileExt);
graphName = strcat(fileName,graphSuf);

[x,Fs] = audioread(wavIn);
T = 1/Fs;
L = length(x);
t = (0:L-1)*T;
Y = fft(x);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(4);
plot(t,x);
title(['Waveform of ' graphName]);
axis([0 .1 -.2 .2]);
figure(5);
plot(f,P1);
title(['Frequency-Domain Spectrum of ' graphName]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
axis([0 1000 0 .1]);
figure(6);
[harmpow,harmNo] = findpeaks(P1,'Threshold',.001,'NPeaks',numHarm);
harmfreq = NaN(size(harmNo));
hCyc = 1;
while hCyc <= length(harmNo)
    harmfreq(hCyc,1) = f(1,harmNo(hCyc,1));
    hCyc = hCyc + 1;
end
plot(harmfreq,harmpow);
title(['Analysed Peak Frequency-Domain Amplitudes of ' graphName]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
axis([0 1000 0 .1]);
end