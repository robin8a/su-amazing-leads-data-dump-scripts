#!/bin/bash
# .properties file
# . /home/pi/scripts/conf/conf.properties
. /home/ec2-user/su-amazing-leads-data-dump-scripts/conf/conf.properties
#sudo find /home/pi/video/* -type d -ctime +3 | xargs rm -rf
sudo find . /home/ec2-user/su-amazing-leads-data-dump-scripts/data/* -type d -ctime +$conf_numbers_days_store | sudo xargs rm -rf
