subs=$(cat SubsList.txt)
for s in $subs
do
echo "Copying fMRI regressors for $s"
cp /data3/NARPS/event_tsvs/"$s"_task-MGT_run-0?_events.tsv "$s"/
sleep 1
done
