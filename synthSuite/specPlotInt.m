function [] = specPlotInt(fileName,numHarm,doPlot)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fileExt = '.wav';
fileSuf = '_Synth';
wavIn = strcat(fileName,fileSuf,fileExt);

[x,Fs] = audioread(wavIn);
if rem(length(x),2) == 1
    [x,Fs] = audioread(wavIn,[1,length(x)-1]);
end

T = 1/Fs;
L = length(x);
t = (0:L-1)*T;
Y = fft(x);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

[harmpow,harmNo] = findpeaks(P1,'MinPeakProminence',.001,'NPeaks',numHarm,'MinPeakDistance',20);
harmfreq = NaN(size(harmNo));
hCyc = 1;
while hCyc <= length(harmNo)
    harmfreq(hCyc,1) = f(1,harmNo(hCyc,1));
    hCyc = hCyc + 1;
end

if doPlot == 1
    figure(4);
    plot(t,x);
    title(['Waveform of Synthesized ' fileName]);
    axis([0 .1 -1 1]);
    figure(5);
    plot(f,P1);
    title(['Frequency-Domain Spectrum of Synthesized ' fileName]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    axis([0 1000 0 .1]);
    figure(6);
    plot(harmfreq,harmpow,'-o');
    title(['Analysed Peak Frequency-Domain Amplitudes of Synthesized ' fileName]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    axis([0 1000 0 .1]);
end
end