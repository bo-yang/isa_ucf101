function [ rcost ] = reconstruct_cost( W, x )
%RECONSTRUCT_COST: reconstruction cost of ICA/ISA

diff=W'*W*x-x;
rcost = 0.5 * sum(sum(diff.^2));

end

