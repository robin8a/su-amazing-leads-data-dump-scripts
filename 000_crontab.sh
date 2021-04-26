# m h  dom mon dow   command
# execute at 23:00 daily, delete folder older than conf.properites /home/ec2-user/su-amazing-leads-data-dump-scripts/data_dump/
0 23 * * * /home/ec2-user/su-amazing-leads-data-dump-scripts/crontab/erase_folder_n_days.sh
# execute at 23:00 daily, data dump dynamo db on /home/ec2-user/su-amazing-leads-data-dump-scripts/data_dump/
0 23 * * * /home/ec2-user/su-amazing-leads-data-dump-scripts/crontab/data_dump.sh

