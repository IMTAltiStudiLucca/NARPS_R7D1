subs=$(cat SubsList.txt)
for s in $subs
do
clear
echo "Smooth and Normalize fMRI data for $s"
sleep 1
for r in 01 02 03 04
do
echo "Processing run $r"
3dBlurToFWHM -input /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_space-MNI152NLin2009cAsym_preproc.nii.gz \
-blurmaster /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_space-MNI152NLin2009cAsym_preproc.nii.gz \
-mask /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz \
-FWHM 5 \
-prefix /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_space-MNI152NLin2009cAsym_5FWHM.nii.gz
sleep 0.5
3dTstat -prefix /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_space-MNI152NLin2009cAsym_avg.nii.gz \
/data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_space-MNI152NLin2009cAsym_5FWHM.nii.gz
sleep 0.5
3dcalc -a /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_space-MNI152NLin2009cAsym_5FWHM.nii.gz \
-b /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_space-MNI152NLin2009cAsym_avg.nii.gz \
-expr '((a/b*100)-100)' \
-prefix /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_space-MNI152NLin2009cAsym_5FWHM_norm.nii.gz
sleep 0.5
rm -rf /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_space-MNI152NLin2009cAsym_5FWHM.nii.gz
done
done
