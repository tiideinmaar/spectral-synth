function [freqX,magX,freqY,magY,freqZ,magZ] = specComp(fileName)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fileExt = '.wav';
fileSuf1 = '_Synth';
fileSuf2 = '_Synth2';
wavInOrig = strcat(fileName,fileExt);
wavInSynth1 = strcat(fileName,fileSuf1,fileExt);
wavInSynth2 = strcat(fileName,fileSuf2,fileExt);

[x,FsO] = audioread(wavInOrig);
[y,FsS1] = audioread(wavInSynth1);
[z,FsS2] = audioread(wavInSynth2);
LO = length(x);
LS1 = length(y);
LS2 = length(z);
X = fft(x);
Y = fft(y);
Z = fft(z);
P2O = abs(X/LO);
P2S1 = abs(Y/LS1);
P2S2 = abs(Z/LS2);
P1O = P2O(1:LO/2+1);
P1S1 = P2S1(1:LS1/2+1);
P1S2 = P2S2(1:LS2/2+1);
P1O(2:end-1) = 2*P1O(2:end-1);
P1S1(2:end-1) = 2*P1S1(2:end-1);
P1S2(2:end-1) = 2*P1S2(2:end-1);
fO = FsO*(0:(LO/2))/LO;
fS1 = FsS1*(0:(LS1/2))/LS1;
fS2 = FsS2*(0:(LS2/2))/LS1;
figure(1);
freqX = fO.';
magX = P1O;
plot(fO,P1O);
title("Single-Sided Amplitude Spectrum of Original Dulcian 8' G4");
xlabel('Freq. (Hz)');
ylabel('Magnitude (abs. Amplitude)');
axis([0 5000 0 .1]);
figure(2);
freqY = fS1.';
magY = P1S1;
plot(fS1,P1S1);
title("Single-Sided Amplitude Spectrum of M1.Synthesized Dulcian 8' G4");
xlabel('Freq. (Hz)');
ylabel('Magnitude (abs. Amplitude)');
axis([0 5000 0 .1]);
figure(3);
freqZ = fS2.';
magZ = P1S2;
plot(fS2,P1S2);
title("Single-Sided Amplitude Spectrum of M2.Synthesized Dulcian 8' G4");
xlabel('Freq. (Hz)');
ylabel('Magnitude (abs. Amplitude)');
axis([0 5000 0 .1]);
end