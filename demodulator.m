function [freqArray,correlatedSignal]=demodulator (windowLength,signal,startSignal,numberOfBits)

signalLength=length(signal);
startSignalLength=length(startSignal);

normSignal=signal/norm(signal);
normStartSignal=startSignal/norm(startSignal);

correlatedSignal=xcorr(normSignal,normStartSignal);
[maxValue,maxIdx]=max(correlatedSignal);

startIdx=maxIdx-signalLength+startSignalLength;
%winsample=cell(8,1);

for i=1:numberOfBits
    window=signal((startIdx+(i-1)*windowLength):(startIdx+i*windowLength));
    [~,freqArray(i)]=max(abs(fft(window)));
    %winsample{i}=window;
    
end
     
end


