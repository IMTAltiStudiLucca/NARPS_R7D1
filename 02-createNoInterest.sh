columnname=X
subs=$(cat SubsList.txt)
for s in $subs
do
echo "Creating AFNI's OrtVec for $s"
for r in 01 02 03 04
do
columnnum=$(sed -n "1 s/${columnname}.*//p" /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_confounds.tsv | sed 's/[^\t*]//g' | wc -c)
echo "For $s run $r, $columnname is the $columnnum column of the confounds.tsv file"
cat /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_confounds.tsv |cut -f "$columnnum"- |tail -n +2 > /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-"$r"_bold_ortvec.1D
sleep 0.5
done
cat /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_run-??_bold_ortvec.1D > /data3/NARPS/equalRange/"$s"/func/"$s"_task-MGT_bold_ortvec.1D
sleep 0.5
done
