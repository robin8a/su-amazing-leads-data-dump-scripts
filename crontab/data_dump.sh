#!/bin/bash
# .properties file
. /home/ec2-user/su-amazing-leads-data-dump-scripts/conf/conf.properties

# Variable load to global use in other scripts
export REC_LOG_FILE=$conf_logs_path"data_dump_"$(date +%d-%m-%Y)".log"
echo "$(date +"%m-%d-%Y %H:%M:%S"): #####" >> $REC_LOG_FILE
echo "$(date +"%m-%d-%Y %H:%M:%S"): Log data dump start" >> $REC_LOG_FILE
export data_dump_today_date=$(date +"%d-%m-%Y")
export scripts_path=$conf_scripts_path
export data_dump_path=$conf_data_dump_path

echo "$(date +"%m-%d-%Y %H:%M:%S"): Today date: $data_dump_today_date" >> $REC_LOG_FILE
echo "$(date +"%m-%d-%Y %H:%M:%S"): Scripts path: $scripts_path" >> $REC_LOG_FILE
echo "$(date +"%m-%d-%Y %H:%M:%S"): Data dump path: $data_dump_path" >> $REC_LOG_FILE

# Checking if date folde exists? to dump data
echo "$(date +"%m-%d-%Y %H:%M:%S"): Checking folders ..." >> $REC_LOG_FILE
if [ ! -d "$data_dump_path$data_dump_today_date" ]; then
    echo "$(date +"%m-%d-%Y %H:%M:%S"): Creating today's directory $data_dump_today_date" >> $REC_LOG_FILE
	mkdir "$data_dump_path$data_dump_today_date"
else 
	echo "$(date +"%m-%d-%Y %H:%M:%S"): The directory $rec_today_date already exist!" >> $REC_LOG_FILE
fi
# Iniciando grabacion cam1
# $scripts_path/011_cam_1_start_recording.sh &

aws dynamodb scan \
    --table-name QuestionAnswer-mexfa73ymfc6rmlwqmt6vu4vf4-suamaleapi \
    --query "Items[*].[id.S, __typename.S, createdAt.S, optionID.S, questionID.S, questionaryInteractionID.S, updatedAt.S]" \
    --filter-expression 'begins_with(createdAt, :val)' \
    --expression-attribute-values '{":val": {"S": "2021-02-12"}}' \
    --output text > "$data_dump_path"QuestionAnswerDataDump_$data_dump_today_date.tsv

