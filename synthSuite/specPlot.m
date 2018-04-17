function [] = specPlot(fileName)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fileExt = '.wav';
wavIn = strcat(fileName,fileExt);

[x,Fs] = audioread(wavIn);
L = length(x);
Y = fft(x);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1);
title("Single-Sided Amplitude Spectrum of Dulcian 8' G4");
xlabel('Freq. (Hz)');
ylabel('Magnitude (abs. Amplitude)');
axis([0 1000 0 .1]);
end