function [] = specCompOS2(fileName)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fileExt = '.wav';
fileSuf = '_Synth2';
wavInOrig = strcat(fileName,fileExt);
wavInSynth = strcat(fileName,fileSuf,fileExt);

[x,FsO] = audioread(wavInOrig);
[y,FsS] = audioread(wavInSynth);
LO = length(x);
LS = length(y);
X = fft(x);
Y = fft(y);
P2O = abs(X/LO);
P2S = abs(Y/LS);
P1O = P2O(1:LO/2+1);
P1S = P2S(1:LS/2+1);
P1O(2:end-1) = 2*P1O(2:end-1);
P1S(2:end-1) = 2*P1S(2:end-1);
fO = FsO*(0:(LO/2))/LO;
fS = FsS*(0:(LS/2))/LS;
figure(1);
plot(fO,P1O);
title("Single-Sided Amplitude Spectrum of Original Dulcian 8' G4");
xlabel('Freq. (Hz)');
ylabel('Magnitude (abs. Amplitude)');
axis([0 1000 0 .1]);
figure(2);
plot(fS,P1S);
title("Single-Sided Amplitude Spectrum of M2.Synthesized Dulcian 8' G4");
xlabel('Freq. (Hz)');
ylabel('Magnitude (abs. Amplitude)');
axis([0 1000 0 .1]);
end