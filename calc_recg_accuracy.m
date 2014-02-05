function [ acc ] = calc_recg_accuracy( test_labels, pred_labels, num_actions )
% Calculate the accuracy of 1-vs-1 action recognition.

num_tpn=0; % true positive & true negative
%for j=1:num_actions
%    tmplabels=j*ones(size(test_labels));
%    idx=(test_labels~=j);
%    tmplabels(idx)=-1;
%    num_tpn=num_tpn+sum(tmplabels==pred_labels(:,j));
%end

%%%%%%%% TEMP CODE ONLY %%%%%%%
for j=1:size(pred_labels,2) %num_actions
    if j<37
        tmplabels=j*ones(size(test_labels));
        idx=(test_labels~=j);
    else
        tmplabels=(j+1)*ones(size(test_labels));
        idx=(test_labels~=(j+1));
    end
    tmplabels(idx)=-1;
    num_tpn=num_tpn+sum(tmplabels==pred_labels(:,j));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

acc=num_tpn/size(test_labels,1);

end

