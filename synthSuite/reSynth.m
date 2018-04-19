function [f,P1,a,harmfreq,harmpow,p] = reSynth(fileName,numHarm,time,doPlot)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fileExt = '.wav';
csvExt = '.csv';
fileSuf = '_Synth';
fileName = input('File Name: ', 's');
[~,~,~,fundOct,note] = reSynthGFI(fileName,fileSuf);
fundOct = str2num(fundOct);
switch note(1,1)
    case 'C'
        fundFreq = 32.7 * fundOct;
    case 'E'
        fundFreq = 41.20 * fundOct;
    case 'G'
        fundFreq = 49.00 * fundOct;
end
if fundOct ==  0
    fundFreq = fundFreq / 2;
elseif fundOct < 0
    fundFreq = fundFreq / abs(2 * fundOct);
end
numHarm = input('Number of Harmonics: ');
time = input('Time (seconds) of signal to generate: ');
doPlot = input('Generate plots? (y/n): ', 's');
filePath = reSynthSFP(fileName,fileSuf);
if exist(filePath) == 0
    mkdir(filePath);
end
wavIn = strcat(fileName,fileExt);
wavOut = strcat(filePath,fileName,fileSuf,fileExt);
csvOut = strcat([filePath,'CSV\',fileName,csvExt]);

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

%[harmpow,harmNo,~,p] = findpeaks(P1,'MinPeakDistance',(fundFreq/4),'Threshold',.0005,'NPeaks',numHarm);
[harmpow,harmNo,~,p] = findpeaks(P1,'SortStr','descend','NPeaks',numHarm,'MinPeakDistance',(fundFreq/4));
harmfreq = NaN(size(harmNo));
hCyc = 1;
while hCyc <= length(harmNo)
    harmfreq(hCyc,1) = f(1,harmNo(hCyc,1));
    hCyc = hCyc + 1;
end

if doPlot == 'y'
    figure(1);
    plot(Vt,x);
    title(['Waveform of ' fileName]);
    grid on;
    grid minor;
    axis([0 .1 -1 1]);
    
    figure(2);
    plot(f,P1);
    title(['Frequency-Domain Spectrum of ' fileName]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    grid on;
    grid minor;
    %axis([0 1000 0 .1]);
    
    figure(3);
    stem(harmfreq,harmpow,'Marker','none');
    title(['Analysed Peak Frequency-Domain Amplitudes of ' fileName]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    grid on;
    grid minor;
    %axis([0 1000 0 .1]);
end

a = [harmpow,harmfreq];
wavVar = a(1,1)*sin(2*pi*a(1,2)*t);
m1 = 2;
while m1 <= length(a)
    h = a(m1,1)*sin(2*pi*a(m1,2)*t);
    wavVar = wavVar + h;
    m1 = m1 + 1;
end
audiowrite('temp_Synth.wav',wavVar,Fs);
if doPlot == 'y'
    specPlotInt('temp',numHarm,fundFreq);
end
userQueryWav = input('Write synthesized signal to .wav file? (y/n): ', 's');
if userQueryWav == 'y'
    csvwrite(csvOut,a);
    audiowrite(wavOut,wavVar,Fs);
    if doPlot == 'y'
        specPlotInt(fileName,numHarm,fundFreq);
    end
end
userQueryFig = input('Save Figures? (y/n): ','s');
if userQueryFig == 'y'
    disp('Saving...');
    reSynthSFF(fileName,fileSuf);
    disp('Saved.');
elseif userQueryFig == 'n'
    disp('Not saved.');
else
    disp('Invalid input. Not saved. Run plotSave(fileName) to save, or reSynth again.');
end
end

function [filePath] = reSynthSFP(fileName,fileSuf)
[rank,foot,type,oct,~] = reSynthGFI(fileName,fileSuf);
filePath = ['D:\OrganSamples\Brombaugh\Ruckpositive\',rank,foot,'\',type,'\Octave',oct,'\'];
end

function [rank,foot,type,oct,note] = reSynthGFI(fileName,fileSuf)
num = '1234567890-';
let = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';

[rank,extra] = strtok(fileName,num);
[foot,noteOct] = strtok(extra,let);
[note,oct] = strtok(noteOct,num);
[~,type] = strtok(fileSuf,let);
end

function reSynthSFF(fileName,fileSuf)

[rank,foot,type,oct,~] = reSynthGFI(fileName,fileSuf);
waveformSuf = '_Wave';
spectrumSuf = '_Spectrum';
peakSuf = '_Peaks';
figExt = 'MATLAB Figures\';
pngExt = 'Resynthesized\';
filePath = ['D:\OrganSamples\Brombaugh\Ruckpositive\',rank,foot,'\',type,'\Octave',oct,'\Graphs\'];
figure(1);
savefig(strcat(filePath,figExt,fileName,waveformSuf));
print(strcat(filePath,pngExt,fileName,waveformSuf),'-dpng');
figure(2);
savefig(strcat(filePath,figExt,fileName,spectrumSuf));
print(strcat(filePath,pngExt,fileName,spectrumSuf),'-dpng');
figure(3);
savefig(strcat(filePath,figExt,fileName,peakSuf));
print(strcat(filePath,pngExt,fileName,peakSuf),'-dpng');
figure(4);
savefig(strcat(filePath,figExt,fileName,fileSuf,waveformSuf));
print(strcat(filePath,pngExt,fileName,fileSuf,waveformSuf),'-dpng');
figure(5);
savefig(strcat(filePath,figExt,fileName,fileSuf,spectrumSuf));
print(strcat(filePath,pngExt,fileName,fileSuf,spectrumSuf),'-dpng');
figure(6);
savefig(strcat(filePath,figExt,fileName,fileSuf,peakSuf));
print(strcat(filePath,pngExt,fileName,fileSuf,peakSuf),'-dpng');
end
