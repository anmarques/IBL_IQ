% MATLAB script meanReCd
%
% Alexandre Noll Marques
% MIT
%
% This script evaluates the mean of the multi-run model for 2ReCd/H*, as
% described in AIAA Journal paper AIAAJ_2016-11-J055877
%
% This script depends on the data file ReCd_multiRun.mat and the functions
% - meanPosteriorMultiRun.m 
% - se1dNoise.m
% - seScaled1d.m
% - zeromean.m
%
% The results are written into a text file
%
% -------------------------------------------------------------------------
%
% User inputs:
%
% H: real vector, values of the shape factor H at which the mean is
%                 computed
%

H = linspace(2, 14, 100);

% -------------------------------------------------------------------------

disp('Reading file ReCd_multiRun.mat...')

load('ReCd_multiRun.mat', 'pos')

disp('Computing the mean...')

ReCd_mean = meanPosteriorMultiRun(H, pos, 2);

disp('Writing values to file...')
filename = 'ReCd_mean.txt';
fid = fopen(filename, 'w');
fprintf(fid, '%10.3e %10.3e\n', [H;ReCd_mean']);

disp('meanReCd finished succesfully')
