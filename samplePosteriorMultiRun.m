% MATLAB function samplePosteriorMultiRun
%
% Alexandre Noll Marques
% MIT
%
% This function generates samples of a posterior Gaussian process
% associated with a multi-run model, as described in AIAA Journal paper
% AIAAJ_2016-11-J055877
%
% -------------------------------------------------------------------------
%
% User inputs:
%
% xe: real vector, values at which the samples are computed
%
% ns: integer, number of samples to be generated
%
% pos: struct, contains the information about the trained multi-run model
%
% input: integer, selects which component of the multi-run model is sampled
%
% eps: real, tolerance in the computation of the SVD of the covariance
%            function
%
% -------------------------------------------------------------------------

function f = samplePosteriorMultiRun(xe,ns,pos,input,eps)

if nargin == 4
    eps = 1e-6;
end

nTask = numel(pos.x);

nEstimate = numel(xe);
nTraining = size(pos.U,2);

Kee = pos.k{input,1}(xe,xe,pos.theta{input});

nParameter = pos.m{input,2};
if nParameter > 0
    Me = pos.m{input,1}(xe,pos.beta{input});
else
    Me = pos.m{input,1}(xe);
end

Ket = zeros(nEstimate,nTraining);

col = 0;
if pos.k{input,3}
    for task = 1:nTask
        nPoint_task = size(pos.x{task},2);
        points = pos.x{task}(input,:);
        col = col(end) + (1:nPoint_task);
        Ket(:,col) = Ket(:,col) + pos.k{input,1}(xe,points,pos.theta{input});
    end
    mean = Me' + Ket*pos.mean;
    cov = Kee - Ket*(pos.V*(pos.S\(pos.U*Ket')));
else
    mean = Me';
    cov = Kee;
end

[V,D] = eig(cov);

S = diag(D);
ic = nnz(S > eps);
V = V(:,1:ic);
D = diag(sqrt(S(1:ic)));
R = V*D;

f = repmat(mean',ns,1) + randn(ns,size(R,2))*R';