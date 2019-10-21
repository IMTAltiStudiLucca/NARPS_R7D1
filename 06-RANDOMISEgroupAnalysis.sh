subs=$(cat SubsList.txt)
for s in $subs
do
echo "Create bucket for $s"
3dbucket -prefix /data3/NARPS/equalRange/"$s"/BUCKET_"$s"_BLOCKDM_GainsTstat.nii \
/data3/NARPS/equalRange/"$s"/RESULTS_"$s"_GLMBLOCKDM_stats.nii.gz_REML+tlrc.'[4]'
#
3dbucket -prefix /data3/NARPS/equalRange/"$s"/BUCKET_"$s"_BLOCKDM_LossesTstat.nii \
/data3/NARPS/equalRange/"$s"/RESULTS_"$s"_GLMBLOCKDM_stats.nii.gz_REML+tlrc.'[6]'
done

fslmerge -t /data3/NARPS/equalRange/NEW_BUCKET_allSubs_BLOCKDM_GainsTstat.nii /data3/NARPS/equalRange/*/BUCKET*BLOCKDM_GainsTstat.nii
fslmerge -t /data3/NARPS/equalRange/NEW_BUCKET_allSubs_BLOCKDM_LossesTstat.nii /data3/NARPS/equalRange/*/BUCKET*BLOCKDM_LossesTstat.nii

3dcalc -a /data3/NARPS/equalRange/NEW_BUCKET_allSubs_BLOCKDM_LossesTstat.nii \
-expr 'a*-1' \
-prefix /data3/NARPS/equalRange/NEW_BUCKET_allSubs_BLOCKDM_LossesTstatInv.nii.gz
3dcalc -a /data3/NARPS/equalRange/NEW_BUCKET_allSubs_BLOCKDM_GainsTstat.nii \
-expr 'a*-1' \
-prefix /data3/NARPS/equalRange/NEW_BUCKET_allSubs_BLOCKDM_GainsTstatInv.nii.gz

3dmask_tool -input /data3/NARPS/equalRange/*/func/*_task-MGT_brainmask.nii.gz \
-prefix /data3/NARPS/equalRange/NEW_GROUPMASK.nii \
-frac 1.0


########## GAINS
# TFCE POSITIVE GAINS
echo "POSITIVE EFFECT OF GAINS"
randomise -i /data3/NARPS/equalRange/NEW_BUCKET_allSubs_BLOCKDM_GainsTstat.nii.gz \
-o /data3/NARPS/equalRange/NEW_RANDOMISE10k-TFCEv5_GROUPRESULTS_BLOCKDM_PositiveEffectGain \
-1 \
-m /data3/NARPS/equalRange/NEW_GROUPMASK.nii \
-v 5 -n 10000 -T

# TFCE NEGATIVE GAINS
echo "NEGATIVE EFFECT OF GAINS"
randomise -i /data3/NARPS/equalRange/NEW_BUCKET_allSubs_BLOCKDM_GainsTstatInv.nii.gz \
-o /data3/NARPS/equalRange/NEW_RANDOMISE10k-TFCEv5_GROUPRESULTS_BLOCKDM_NegativeEffectGain \
-1 \
-m /data3/NARPS/equalRange/NEW_GROUPMASK.nii \
-v 5 -n 10000 -T


########## LOSSES
# TFCE POSITIVE LOSSES
echo "POSITIVE EFFECT OF LOSSES"
randomise -i /data3/NARPS/equalRange/NEW_BUCKET_allSubs_BLOCKDM_LossesTstat.nii.gz \
-o /data3/NARPS/equalRange/NEW_RANDOMISE10k-TFCEv5_GROUPRESULTS_BLOCKDM_PositiveEffectLosses \
-1 \
-m /data3/NARPS/equalRange/NEW_GROUPMASK.nii \
-v 5 -n 10000 -T

# TFCE NEGATIVE LOSSES
echo "NEGATIVE EFFECT OF LOSSES"
randomise -i /data3/NARPS/equalRange/NEW_BUCKET_allSubs_BLOCKDM_LossesTstatInv.nii.gz \
-o /data3/NARPS/equalRange/NEW_RANDOMISE10k-TFCEv5_GROUPRESULTS_BLOCKDM_NegativeEffectLosses \
-1 \
-m /data3/NARPS/equalRange/NEW_GROUPMASK.nii \
-v 5 -n 10000 -T


