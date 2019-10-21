subs=$(cat SubsList.txt)
for s in $subs
do
clear
echo "GLM analysis for $s"
noresp=$(cat /data3/NARPS/equalRange/"$s"/"$s"_task-MGT_NoResp_regressor.1D |grep "*" |wc -w)
sleep 1
if [ "$noresp" == 4 ]; then
echo "$s responded to all trials"
3dDeconvolve -input /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-??_bold_space-MNI152NLin2009cAsym_5FWHM_norm.nii.gz \
-mask /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_brainmask.nii.gz \
-jobs 8 \
-polort A \
-local_times \
-num_stimts 1 \
-stim_times_AM2 1 /data3/NARPS/equalRange/"$s"/"$s"_task-MGT_AM2BLOCKDM_regressor.1D 'dmBLOCK(1)' :12.5:12.5 \
-stim_label 1 'Task' \
-ortvec /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_bold_ortvec.1D 'NoInterest' \
-x1D /data3/NARPS/equalRange/"$s"/RESULTS_"$s"_GLMBLOCKDM_matrix.xmat.1D \
-tout \
-bucket /data3/NARPS/equalRange/"$s"/RESULTS_"$s"_GLMBLOCKDM_stats.nii.gz
else
echo "$s had at least 1 no response trial"
3dDeconvolve -input /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-??_bold_space-MNI152NLin2009cAsym_5FWHM_norm.nii.gz \
-mask /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_brainmask.nii.gz \
-jobs 8 \
-polort A \
-local_times \
-num_stimts 2 \
-stim_times_AM2 1 /data3/NARPS/equalRange/"$s"/"$s"_task-MGT_AM2BLOCKDM_regressor.1D 'dmBLOCK(1)' :12.5:12.5 \
-stim_label 1 'Task' \
-stim_times 2 /data3/NARPS/equalRange/"$s"/"$s"_task-MGT_NoResp_regressor.1D 'BLOCK(4,1)' \
-stim_label 2 'NoResp' \
-ortvec /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_bold_ortvec.1D 'NoInterest' \
-x1D /data3/NARPS/equalRange/"$s"/RESULTS_"$s"_GLMBLOCKDM_matrix.xmat.1D \
-tout \
-bucket /data3/NARPS/equalRange/"$s"/RESULTS_"$s"_GLMBLOCKDM_stats.nii.gz
fi
#
echo "REML analysis for $s"
bash /data3/NARPS/equalRange/"$s"/RESULTS_"$s"_GLMBLOCKDM_stats.REML_cmd
done


