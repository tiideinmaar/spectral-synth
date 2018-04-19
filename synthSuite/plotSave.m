function plotSave(fileName)
fileSuf = '_Synth';
[rank,foot,type,oct] = reSynthGFI(fileName,fileSuf);
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

function [rank,foot,type,oct] = reSynthGFI(fileName,fileSuf)
num = '1234567890';
let = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';

[rank,extra] = strtok(fileName,num);
[foot,noteOct] = strtok(extra,let);
[~,oct] = strtok(noteOct,num);
[~,type] = strtok(fileSuf,let);
end