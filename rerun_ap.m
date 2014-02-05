mean_ap_list = zeros(params.num_km_init,1);
mean_acc_list = zeros(params.num_km_init,1);
all_svm_pred=struct('labels',[],'accuracy',0);
recg_accu=zeros(params.num_km_init,1);

for ini_idx = 1:params.num_km_init

    fprintf('binning VQ labels.... \n')
    %%------------------ form svm inputs by binning ----------------------
    Xtrain = formhist_stackisa(train_label_all, train_indices, params, MM_train, length(all_train_files), ini_idx);
    Xtest = formhist_stackisa(test_label_all, test_indices, params, MM_test, length(all_test_files), ini_idx);

    %%------------------ run SVM to classify data---------------------------
    norm_type = params.norm_type;
    unscramble = params.unscramble;  
    [all_svm_pred(ini_idx), mean_ap_list(ini_idx), mean_acc_list(ini_idx)] = normalize_chi_svm_wangs(Xtrain, Xtest, norm_type, all_train_files, all_test_files, all_train_labels, all_test_labels, unscramble, params.infopath, 0);    
	%all_svm_pred(ini_idx).accuracy=calc_recg_accuracy(all_test_files,all_svm_pred(ini_idx).labels, params.infopath);
end

date=datestr(now,29);
mkdir([params.savepath, date]);

fprintf('---------------SVM RESULTS---------------\n');
for ini_idx = 1:params.num_km_init
    fprintf('%d th initialization: mean_ap = %f, mean_acc = %f, km_obj = %f\n', ini_idx,mean_ap_list(ini_idx), mean_acc_list(ini_idx), km_obj{ini_idx});
end

svm_pred_filename = sprintf('svm_pred_%s', params.testid);
save([params.savepath,date,'/',svm_pred_filename],'all_svm_pred');