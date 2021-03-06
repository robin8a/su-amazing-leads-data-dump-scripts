#!/bin/bash
# .properties file
. /home/ubuntu/su-amazing-leads-data-dump-scripts/conf/conf.properties
# argument variables
param_data_dump_start_date=$1

# Variable load to global use in other scripts
export REC_LOG_FILE=$conf_logs_path"data_dump_"$(date +%Y%m%d)".log"
export backup_start_date=`date -d "$param_data_dump_start_date" +"%Y-%m-%d"`

echo "$(date +"%m-%d-%Y %H:%M:%S"): #####" >> $REC_LOG_FILE
echo "$(date +"%m-%d-%Y %H:%M:%S"): Log data dump start" >> $REC_LOG_FILE
export data_dump_today_date=`date -d "$backup_start_date" +"%Y%m%d%H%M%S"`
export data_dump_today_date_param=`date -d "$backup_start_date" +"%Y-%m-%d"`
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
# Data dump

echo "$(date +"%m-%d-%Y %H:%M:%S"): Starting Data Dump ..." >> $REC_LOG_FILE

## Interaction
aws dynamodb scan \
    --table-name Interaction-mexfa73ymfc6rmlwqmt6vu4vf4-suamaleapi \
    --query "Items[*].[id.S, __typename.S, countOutside.N, createdAt.S, distance.N, distance_left_button_point.N, distance_questionary_point.N, distance_right_button_point.N, dt.N, element.S, epoch.N, height.N, isActive.BOOL, isMouseDetected.BOOL, isPositionOutside.BOOL, isTouchDetected.BOOL, questionID.S, questionaryInteractionID.S, speed.N, speedAverage.N, sumDistance.N, sumTimeMiliseconds.N, sumTimeMilisecondsBeforeNextQuestion.N, type.S, updatedAt.S, width.N, x.N, y.N]" \
    --filter-expression 'begins_with(createdAt, :val)' \
    --expression-attribute-values '{":val": {"S": "'$data_dump_today_date_param'"}}' \
    --output text > "$data_dump_path$data_dump_today_date/"iff001_santander_interactions_$data_dump_today_date.tsv

echo "$(date +"%m-%d-%Y %H:%M:%S"): Interaction table Data Dumped ..." >> $REC_LOG_FILE

echo "$(date +"%m-%d-%Y %H:%M:%S"): Conveting tsv to csv table: Interaction ..." >> $REC_LOG_FILE
tr '\t' ',' < "$data_dump_path$data_dump_today_date/"iff001_santander_interactions_$data_dump_today_date.tsv > "$data_dump_path$data_dump_today_date/"iff001_santander_interactions_$data_dump_today_date.csv
echo "$(date +"%m-%d-%Y %H:%M:%S"): Converted to csv table: Interaction" >> $REC_LOG_FILE

if [ -s "$data_dump_path$data_dump_today_date/"iff001_santander_interactions_$data_dump_today_date.csv ]
then
        gsutil -m cp -r "$data_dump_path$data_dump_today_date/"iff001_santander_interactions_$data_dump_today_date.csv gs://santander_inbox/amazing_leads/detailed_interaction
else
        echo "$(date +"%m-%d-%Y %H:%M:%S"): The file iff001_santander_interactions is empty" >> $REC_LOG_FILE
fi



## Option
aws dynamodb scan \
    --table-name Option-mexfa73ymfc6rmlwqmt6vu4vf4-suamaleapi \
    --query "Items[*].[id.S, orderNumber.N, questionID.S, title.S]" \
    --output text > "$data_dump_path$data_dump_today_date/"iff002_santander_options_$data_dump_today_date.tsv

echo "$(date +"%m-%d-%Y %H:%M:%S"): Option table Data Dumped ..." >> $REC_LOG_FILE

echo "$(date +"%m-%d-%Y %H:%M:%S"): Conveting tsv to csv table: Option ..." >> $REC_LOG_FILE
tr '\t' ',' < "$data_dump_path$data_dump_today_date/"iff002_santander_options_$data_dump_today_date.tsv > "$data_dump_path$data_dump_today_date/"iff002_santander_options_$data_dump_today_date.csv
echo "$(date +"%m-%d-%Y %H:%M:%S"): Converted to csv table: Option" >> $REC_LOG_FILE

if [ -s "$data_dump_path$data_dump_today_date/"iff002_santander_options_$data_dump_today_date.csv ]
then
        gsutil -m cp -r "$data_dump_path$data_dump_today_date/"iff002_santander_options_$data_dump_today_date.csv gs://santander_inbox/amazing_leads/options_data
else
        echo "$(date +"%m-%d-%Y %H:%M:%S"): The file iff001_santander_interactions is empty" >> $REC_LOG_FILE
fi


## QuestionaryInteraction
aws dynamodb scan \
    --table-name QuestionaryInteraction-mexfa73ymfc6rmlwqmt6vu4vf4-suamaleapi \
    --query "Items[*].[id.S, __typename.S, browser.S, clientID.S, createdAt.S, ip.S, isBrowser.BOOL, isMobile.BOOL, questionaryEndTime.N, questionaryID.S, questionaryStartTime.N, state_0.N, state_1.N, state_2.N, updatedAt.S, utm.s]" \
    --filter-expression 'begins_with(createdAt, :val)' \
    --expression-attribute-values '{":val": {"S": "'$data_dump_today_date_param'"}}' \
    --output text > "$data_dump_path$data_dump_today_date/"iff003_santander_questionary_interaction_$data_dump_today_date.tsv
    
echo "$(date +"%m-%d-%Y %H:%M:%S"): QuestionaryInteraction table Data Dumped ..." >> $REC_LOG_FILE

echo "$(date +"%m-%d-%Y %H:%M:%S"): Conveting tsv to csv table: QuestionaryInteraction ..." >> $REC_LOG_FILE
tr '\t' ',' < "$data_dump_path$data_dump_today_date/"iff003_santander_questionary_interaction_$data_dump_today_date.tsv > "$data_dump_path$data_dump_today_date/"iff003_santander_questionary_interaction_$data_dump_today_date.csv
echo "$(date +"%m-%d-%Y %H:%M:%S"): Converted to csv table: QuestionaryInteraction" >> $REC_LOG_FILE

if [ -s "$data_dump_path$data_dump_today_date/"iff003_santander_questionary_interaction_$data_dump_today_date.csv ]
then
        gsutil -m cp -r "$data_dump_path$data_dump_today_date/"iff003_santander_questionary_interaction_$data_dump_today_date.csv gs://santander_inbox/amazing_leads/questionnaire_interaction
else
        echo "$(date +"%m-%d-%Y %H:%M:%S"): The file iff001_santander_interactions is empty" >> $REC_LOG_FILE
fi


## Question
aws dynamodb scan \
    --table-name Question-mexfa73ymfc6rmlwqmt6vu4vf4-suamaleapi \
    --query "Items[*].[id.S, isEnable.BOOL, orderNumber.N, question.S, questionaryID.S]" \
    --output text > "$data_dump_path$data_dump_today_date/"iff004_santander_questions_$data_dump_today_date.tsv
    
echo "$(date +"%m-%d-%Y %H:%M:%S"): Question table Data Dumped ..." >> $REC_LOG_FILE

echo "$(date +"%m-%d-%Y %H:%M:%S"): Conveting tsv to csv table: Question ..." >> $REC_LOG_FILE
tr '\t' ',' < "$data_dump_path$data_dump_today_date/"iff004_santander_questions_$data_dump_today_date.tsv > "$data_dump_path$data_dump_today_date/"iff004_santander_questions_$data_dump_today_date.csv
echo "$(date +"%m-%d-%Y %H:%M:%S"): Converted to csv table: Question" >> $REC_LOG_FILE


if [ -s "$data_dump_path$data_dump_today_date/"iff004_santander_questions_$data_dump_today_date.csv ]
then
    gsutil -m cp -r "$data_dump_path$data_dump_today_date/"iff004_santander_questions_$data_dump_today_date.csv gs://santander_inbox/amazing_leads/questions
else
    echo "$(date +"%m-%d-%Y %H:%M:%S"): The file iff001_santander_interactions is empty" >> $REC_LOG_FILE
fi


## QuestionAnswer
aws dynamodb scan \
    --table-name QuestionAnswer-mexfa73ymfc6rmlwqmt6vu4vf4-suamaleapi \
    --query "Items[*].[id.S, __typename.S, createdAt.S, optionID.S, questionID.S, questionaryInteractionID.S, updatedAt.S]" \
    --filter-expression 'begins_with(createdAt, :val)' \
    --expression-attribute-values '{":val": {"S": "'$data_dump_today_date_param'"}}' \
    --output text > "$data_dump_path$data_dump_today_date/"iff005_santander_question_answer_$data_dump_today_date.tsv

echo "$(date +"%m-%d-%Y %H:%M:%S"): QuestionAnswer table Data Dumped ..." >> $REC_LOG_FILE

echo "$(date +"%m-%d-%Y %H:%M:%S"): Conveting tsv to csv table: QuestionAnswer ..." >> $REC_LOG_FILE
tr '\t' ',' < "$data_dump_path$data_dump_today_date/"iff005_santander_question_answer_$data_dump_today_date.tsv > "$data_dump_path$data_dump_today_date/"iff005_santander_question_answer_$data_dump_today_date.csv
echo "$(date +"%m-%d-%Y %H:%M:%S"): Converted to csv table: QuestionAnswer" >> $REC_LOG_FILE

if [ -s "$data_dump_path$data_dump_today_date/"iff005_santander_question_answer_$data_dump_today_date.csv ]
then
    gsutil -m cp -r "$data_dump_path$data_dump_today_date/"iff005_santander_question_answer_$data_dump_today_date.csv gs://santander_inbox/amazing_leads/question_answers
else
    echo "$(date +"%m-%d-%Y %H:%M:%S"): The file iff001_santander_interactions is empty" >> $REC_LOG_FILE
fi

# ## Uploading the complete daily data dump folder

# gsutil -m cp -r "$data_dump_path$data_dump_today_date" gs://santander_inbox/amazing_leads

echo "$(date +"%m-%d-%Y %H:%M:%S"): #####" >> $REC_LOG_FILE

