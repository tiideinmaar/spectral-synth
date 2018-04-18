function [f,P1,a,harmfreq,harmpow,p] = reSynth(fileName,numHarm,time,doPlot)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fileExt = '.wav';
fileSuf = '_Synth';
filePath = reSynthFFP(fileName,fileSuf);
if exist(filePath) == 0
    mkdir(filePath);
end
wavIn = strcat(fileName,fileExt);
wavOut = strcat(filePath,fileName,fileSuf,fileExt);

[x,Fs] = audioread(wavIn);
if rem(length(x),2) == 1
    [x,Fs] = audioread(wavIn,[1,length(x)-1]);
end

y = fft(x);
Ts = 1/Fs;
L = length(x);
t = 0:Ts:time;
Vt = (0:L-1)*Ts;
P2 = abs(y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

[harmpow,harmNo,~,p] = findpeaks(P1,'MinPeakProminence',.001,'NPeaks',numHarm,'MinPeakDistance',20);
harmfreq = NaN(size(harmNo));
hCyc = 1;
while hCyc <= length(harmNo)
    harmfreq(hCyc,1) = f(1,harmNo(hCyc,1));
    hCyc = hCyc + 1;
end

if doPlot == 1
    figure(1);
    plot(Vt,x);
    title(['Waveform of ' fileName]);
    axis([0 .1 -1 1]);
    figure(2);
    plot(f,P1);
    title(['Frequency-Domain Spectrum of ' fileName]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    axis([0 1000 0 .1]);
    figure(3);
    plot(harmfreq,harmpow,'-o');
    title(['Analysed Peak Frequency-Domain Amplitudes of ' fileName]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    axis([0 1000 0 .1]);
end

a = [harmpow,harmfreq];
wavVar = a(1,1)*sin(2*pi*a(1,2)*t);
m1 = 2;
while m1 <= length(a)
    h = a(m1,1)*sin(2*pi*a(m1,2)*t);
    wavVar = wavVar + h;
    m1 = m1 + 1;
end
audiowrite(wavOut,wavVar,Fs);
specPlotInt(fileName,numHarm,doPlot);
end

function [filePath] = reSynthFFP(fileName,fileSuf)

num = '1234567890';
let = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';

[rank,extra] = strtok(fileName,num);
[foot,noteOct] = strtok(extra,let);
[~,oct] = strtok(noteOct,num);
[~,type] = strtok(fileSuf,let);

filePath = ['D:\OrganSamples\Brombaugh\Ruckpositive\',rank,foot,'\',type,'\Octave',oct,'\'];
end
