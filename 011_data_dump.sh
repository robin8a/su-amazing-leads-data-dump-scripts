#!/bin/bash
export path_video_cam=$video_path$rec_today_date/$rec_cam1_name
export video_name=$vehicle_tag"_"$rec_cam1_name"_""$(date +"%d-%m-%Y_%H-%M-%S")"

echo "$(date +"%m-%d-%Y %H:%M:%S"): ####" >> $REC_LOG_FILE
echo "$(date +"%m-%d-%Y %H:%M:%S"): Rec path video/camara: $path_video_cam" >> $REC_LOG_FILE
echo "$(date +"%m-%d-%Y %H:%M:%S"): Video name: $video_name" >> $REC_LOG_FILE
echo "$(date +"%m-%d-%Y %H:%M:%S"): Checking if the camera1 (raspberry) is connected ..." >> $REC_LOG_FILE

echo "$(date +"%m-%d-%Y %H:%M:%S"): Checking if the folder for Cam_1 is available..." >> $REC_LOG_FILE
if [ ! -d "$path_video_cam" ]; then
	echo "$(date +"%m-%d-%Y %H:%M:%S"): Folder doesn't exits, creating camera's 1 folder $path_video_cam" >> $REC_LOG_FILE
	mkdir "$path_video_cam"
else
	echo "$(date +"%m-%d-%Y %H:%M:%S"): The directory $path_video_cam already exist!" >> $REC_LOG_FILE
fi
echo "$(date +"%m-%d-%Y %H:%M:%S"): Getting video from Cam_1" >> $REC_LOG_FILE
$scripts_path/0111_hls.sh