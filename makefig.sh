#!/bin/sh

#1day tail
tail -n 1440 /home/pi/denpa-gardening/sensor_data/sensor_data.csv > ttail.csv
mv ttail.csv /home/pi/denpa-gardening/sensor_data/sensor_data.csv

#generating graph
python makefig.py /home/pi/denpa-gardening/sensor_data/sensor_data.csv
#move image to web
mv sensor_data.png /var/www/html

