function [NWords, PWords, Words, Seq] = getWordsDistr (Gamma,T,tau,L,shift)
% Computes histograms of words 
%
% INPUTS:
% Gamma: state time courses
% T: length of the trials
% tau: the length of the bins
% L: the lengths of the words to be considered (in no. of bins)
% shift: how many time points we shift the window to get each successive word 
%           
% OUTPUTS:
% NWords: Histogram of words
% PWords: Probability of each word
% Words: matrix of words, with one row per word
% Seq: sequence of words
%
% Author: Diego Vidaurre, OHBA, University of Oxford


if nargin<5, shift = 1; end

Words = []; 
NWords = []; 
Seq = [];
bins = 1:tau:tau*L;
for in = 1:length(T)
    ini = sum(T(1:in-1));
    for t = ini+1:shift:ini+T(in)-tau*L+1
        word = getWord(Gamma(t:t+tau*L-1,:),bins,tau);
        pos = WordPosition(Words,word);
        if isempty(pos)
            Words = [Words; word];
            NWords = [NWords 1];
            Seq = [Seq; size(Words,1)];
        else
            NWords(pos) = NWords(pos) + 1;
            Seq = [Seq; pos];
        end
    end
end
[NWords,I] = sort(NWords,'descend');
Words = Words(I,:);
PWords = NWords / sum(NWords);

end



%function r = cartesianProd(p,q)
%[X,Y] = meshgrid(p,q);
%r = [X(:) Y(:)];
%end





