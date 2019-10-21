# This block creates AFNI's amplitude modulation regressors for trials in
# which the subject gave a specific response (weakly/strongly accept/reject).
# It also takes into account response time
subs=$(cat SubsList.txt)
for s in $subs
do
echo "Creating AFNI's stim_times_AM for $s"
for r in 01 02 03 04
do
cat /data3/NARPS/equalRange/"$s"/"$s"_task-MGT_run-"$r"_events.tsv |tail -n +2 |grep -wv "NoResp" |cut -f1 |tr -d "\t" > /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-"$r"_onset.1D
cat /data3/NARPS/equalRange/"$s"/"$s"_task-MGT_run-"$r"_events.tsv |tail -n +2 |grep -wv "NoResp" |cut -f3 |tr -d "\t" > /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-"$r"_gains.1D
cat /data3/NARPS/equalRange/"$s"/"$s"_task-MGT_run-"$r"_events.tsv |tail -n +2 |grep -wv "NoResp" |cut -f4 |tr -d "\t" > /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-"$r"_losses.1D
cat /data3/NARPS/equalRange/"$s"/"$s"_task-MGT_run-"$r"_events.tsv |tail -n +2 |grep -wv "NoResp" |cut -f5 |tr -d "\t" > /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-"$r"_resptime.1D
#
1dMarry -sep '*,:' /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-"$r"_onset.1D /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-"$r"_gains.1D /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-"$r"_losses.1D /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-"$r"_resptime.1D |tr -d " " |tr "\n" " " > /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-"$r"_regressor.1D
done
r1=$(cat /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-01_regressor.1D)
r2=$(cat /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-02_regressor.1D)
r3=$(cat /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-03_regressor.1D)
r4=$(cat /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-04_regressor.1D)
echo -e "$r1\n$r2\n$r3\n$r4" > /data3/NARPS/equalRange/"$s"/"$s"_task-MGT_AM2BLOCKDM_regressor.1D
sleep 0.5
rm -rf /data3/NARPS/equalRange/"$s"/TeMp_"$s"_task-MGT_run-??_*.1D
sleep 0.5
done
#
# This block creates regressors for the "NoResp" trials
#
subs=$(cat SubsList.txt)
for s in $subs
do
echo "Creating AFNI's NoResp stim_times for $s"
for r in 01 02 03 04
do
timing=$(cat "$s"/"$s"_task-MGT_run-"$r"_events.tsv |grep -w "NoResp" |cut -f1 |tr "\n" " ")
if [ -z "$timing" ]; then
echo '*' >> /data3/NARPS/equalRange/"$s"/"$s"_task-MGT_NoResp_regressor.1D
else
echo "$timing" >> /data3/NARPS/equalRange/"$s"/"$s"_task-MGT_NoResp_regressor.1D
fi
done
sleep 1
done
