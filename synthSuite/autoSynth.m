function [wavForm,harmpow2,Fs,a] = autoSynth(fileName,numHarm)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fileExt = '.wav';
fileSuf = '_Synth';
wavIn = strcat(fileName,fileExt);
wavOut = strcat(fileName,fileSuf,fileExt);

[x,Fs] = audioread(wavIn);
[~,harmpow,harmfreq] = thd(x,Fs,numHarm);
harmpow2 = db2mag(harmpow);
a = [harmpow2,harmfreq];
t = linspace(0,1,Fs);
wavVar = a(1,1)*sin(2*pi*a(1,2)*t);
m1 = 2;
while m1 <= numHarm
    h = a(m1,1)*sin(2*pi*a(m1,2)*t);
    wavVar = wavVar + h;
    m1 = m1 + 1;
end
wavForm = wavVar;
audiowrite(wavOut,wavVar,Fs);
end