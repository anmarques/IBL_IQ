% MATLAB script sampleReCf
%
% Alexandre Noll Marques
% MIT
%
% This script generates samples of the multi-run model for ReCf/2, as
% described in AIAA Journal paper AIAAJ_2016-11-J055877
%
% This script depends on the data file ReCf_multiRun.mat and the functions
% - samplePosteriorMultiRun.m 
% - se1dNoise.m
% - seScaled1d.m
% - zeromean.m
%
% The samples are written into text files. Two files are generated for each
% sample: one for the resolved component of the multi-run model, and one
% for the unresolved component
%
% -------------------------------------------------------------------------
%
% User inputs:
%
% nsamples: integer, number of samples to be generated
%
% H: real vector, values of the shape factor H at which the samples of the
%                 resolved part of the model are computed
%
% xi: real vector, values of the non-dimensional arc-length position at
%                  which the samples of the unresolved part of the model
%                  are computed
%

nsamples = 10;
H = linspace(2, 14, 100);
xi = linspace(0, 3, 100);

% -------------------------------------------------------------------------

disp('Reading file ReCf_multiRun.mat...')

load('ReCf_multiRun.mat', 'pos')

disp('Generating samples...')

ReCf_r = samplePosteriorMultiRun(H, nsamples, pos, 2);
ReCf_u = samplePosteriorMultiRun(xi, nsamples, pos, 1);

disp('Writing samples to file...')

for i = 1:nsamples
    filename = ['ReCf_sample_',num2str(i),'_r.txt'];
    fid = fopen(filename, 'w');
    fprintf(fid, '%10.3e %10.3e\n', [H;ReCf_r(i,:)]);
    fclose(fid);

    filename = ['ReCf_sample_',num2str(i),'_u.txt'];
    fid = fopen(filename, 'w');
    fprintf(fid, '%10.3e %10.3e\n', [xi;ReCf_u(i,:)]);
    fclose(fid);
end

disp('sampleReCf finished succesfully')
