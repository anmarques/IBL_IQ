% MATLAB function meanPosteriorMultiRun
%
% Alexandre Noll Marques
% MIT
%
% This function evalutaes the mean of a posterior Gaussian process
% associated with a multi-run model, as described in AIAA Journal paper
% AIAAJ_2016-11-J055877
%
% -------------------------------------------------------------------------
%
% User inputs:
%
% xe: real vector, values at which the samples are computed
%
% pos: struct, contains the information about the trained multi-run model
%
% input: integer, selects which component of the multi-run model is sampled
%
% -------------------------------------------------------------------------

function mean = meanPosteriorMultiRun(xe,pos,input)

nTask = numel(pos.x);

nEstimate = numel(xe);
nTraining = size(pos.U,2);

Ket = zeros(nEstimate,nTraining);

col = 0;
for task = 1:nTask
    nPoint_task = size(pos.x{task},2);
    points = pos.x{task}(input,:);
    col = col(end) + (1:nPoint_task);
    Ket(:,col) = Ket(:,col) + pos.k{input,1}(xe,points,pos.theta{input});
end
nParameter = pos.m{input,2};
if nParameter > 0
    Me = pos.m{input,1}(xe,pos.beta{input});
else
    Me = pos.m{input,1}(xe);
end
Kee = pos.k{input,1}(xe,[],pos.theta{input});

mean = Me' + Ket*pos.mean;