function [soundSignal,numberOfBits,bitGuide]=modulator(stringVal,startSignalFreq,startSignalLength,bits,bitLength,Fs)

stringVal=[stringVal char(255)];%tertemiz cakkallik

%create start signal
t=0:1/Fs:startSignalLength;
startSignal=sin(2*pi*startSignalFreq*t);

%create bits
tbit=0:1/Fs:bitLength;

numberOfBits=length(bits);
bitGuide=cell(1,numberOfBits);

soundSignal=startSignal;

for i=1:numberOfBits
    bitGuide{i}=sin(2*pi*bits(i)*tbit);
    soundSignal=[soundSignal bitGuide{i}];
end

%base number of bits
baseNum=numberOfBits;
bitsPerChar=ceil(log(256)/log(baseNum));

numString=num2str(dec2base(double(stringVal),baseNum));
[numberOfChar,bitsPerChar]=size(numString);
numberOfBits=numberOfChar*bitsPerChar;

soundSignal=startSignal;

for i=1:numberOfChar
    for j=1:bitsPerChar
         soundSignal=[soundSignal bitGuide{str2num(numString(i,j))+1}];
    end
end
end
