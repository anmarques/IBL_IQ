function k = seScaled1d(xp,xq,theta)

np = size(xp,2);
if isempty(xq)
    ap = theta(1)*xp/theta(3) + theta(2);
    xp = repmat(xp,np,1);
    k = (ap'*ap).*exp(-((xp-xp')/theta(3)).^2/2);
else
    ap = theta(1)*xp/theta(3) + theta(2);
    aq = theta(1)*xq/theta(3) + theta(2);
    nq = size(xq,2);
    xp = repmat(xp,nq,1)';
    xq = repmat(xq,np,1);
    k = (ap'*aq).*exp(-((xp-xq)/theta(3)).^2/2);
end

end