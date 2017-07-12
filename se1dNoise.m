function k = se1dNoise(xp,xq,theta)

np = size(xp,2);
if isempty(xq)
    xp = repmat(xp,np,1);
    dist = xp - xp';
    I = eye(np);
else
    nq = size(xq,2);
    xp = repmat(xp,nq,1)';
    xq = repmat(xq,np,1);
    dist = xp - xq;
    I = zeros(np,nq);
end

k = (theta(1)^2)*exp(-(dist/theta(3)).^2/2) + theta(2)^2*I;

end