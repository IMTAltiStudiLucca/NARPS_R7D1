subs=$(cat SubsList.txt)
for s in $subs
do
echo "Create Single Subject GLM analysis mask for $s"
sleep 1
3dmask_tool -input /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-??_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz \
-prefix /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_brainmask.nii.gz \
-frac 1.0
done
