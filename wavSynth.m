function [wavForm,Fs,a] = wavSynth(fileName,Fs,fundFreq)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

csvExt = '.csv';
fileSufExt = '_Synth.wav';
csvIn = strcat(fileName,csvExt);
wavOut = strcat(fileName,fileSufExt);
magList = csvread(csvIn);
sz = length(magList);
N = 1;
freqList = zeros(N,1);
while N <= sz
    freqList(N,1) = (N * fundFreq);
    N = N + 1;
end
a = [magList,freqList];
t = linspace(0,1,Fs);
wavVar = a(1,1)*sin(2*pi*a(1,2)*t);
m1 = 2;
while m1 <= length(freqList)
    h = a(m1,1)*sin(2*pi*a(m1,2)*t);
    wavVar = wavVar + h;
    m1 = m1 + 1;
end
wavForm = wavVar;
audiowrite(wavOut,wavVar,Fs);
end