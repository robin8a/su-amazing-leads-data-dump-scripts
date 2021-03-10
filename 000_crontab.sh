# m h  dom mon dow   command
# */1 * * * *   /home/pi/Scripts/Startrecording-m3u8.sh
# execute at 2am daily, delete folder older than conf.properites /home/ec2-user/su-amazing-leads-data-dump-scripts/
0 2 * * * /home/ec2-user/su-amazing-leads-data-dump-scripts/crontab/erase_folder_n_days.sh
# Verifica si una grabacion se realiza a las 12 am
# 0 0 * * * /home/ec2-user/su-amazing-leads-data-dump-scripts/crontab/restart_video_rec_cams_new_day.sh