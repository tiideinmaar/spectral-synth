function [] = specCompS1S2(fileName)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fileExt = '.wav';
fileSuf1 = '_Synth';
fileSuf2 = '_Synth2';
wavInSynth1 = strcat(fileName,fileSuf1,fileExt);
wavInSynth2 = strcat(fileName,fileSuf2,fileExt);

[x,FsS1] = audioread(wavInSynth1);
[y,FsS2] = audioread(wavInSynth2);
LS1 = length(x);
LS2 = length(y);
X = fft(x);
Y = fft(y);
P2S1 = abs(X/LS1);
P2S2 = abs(Y/LS2);
P1S1 = P2S1(1:LS1/2+1);
P1S2 = P2S2(1:LS2/2+1);
P1S1(2:end-1) = 2*P1S1(2:end-1);
P1S2(2:end-1) = 2*P1S2(2:end-1);
fS1 = FsS1*(0:(LS1/2))/LS1;
fS2 = FsS2*(0:(LS2/2))/LS2;
figure(1);
plot(fS1,P1S1);
title("Single-Sided Amplitude Spectrum of M1.Synthesized Dulcian 8' G4");
xlabel('Freq. (Hz)');
ylabel('Magnitude (abs. Amplitude)');
axis([0 1000 0 .1]);
figure(2);
plot(fS2,P1S2);
title("Single-Sided Amplitude Spectrum of M2.Synthesized Dulcian 8' G4");
xlabel('Freq. (Hz)');
ylabel('Magnitude (abs. Amplitude)');
axis([0 1000 0 .1]);
end