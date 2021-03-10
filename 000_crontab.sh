# m h  dom mon dow   command
# */1 * * * *   /home/pi/Scripts/Startrecording-m3u8.sh
# execute at 2am daily y borra las carpetas mayor a dos dias de video
0 2 * * * /home/pi/scripts/crontab/erase_folder_n_days.sh
# Verifica si una grabacion se realiza a las 12 am
0 0 * * * /home/pi/scripts/crontab/restart_video_rec_cams_new_day.sh