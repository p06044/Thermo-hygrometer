#!/bin/sh

#dailychart
time=`sed -n 1400p denpa-gardening/sensor_data/sensor_data.csv  | awk -F ',' '{print $1}' | awk -F ' ' '{print $1}'`
temp=`cat denpa-gardening/sensor_data/sensor_data.csv  | awk -F ',' '{m+=$2} END{print m/NR;}'`
humi=`cat denpa-gardening/sensor_data/sensor_data.csv  | awk -F ',' '{m+=$3} END{print m/NR;}'`
pres=`cat denpa-gardening/sensor_data/sensor_data.csv  | awk -F ',' '{m+=$4} END{print m/NR;}'`

Mtemp=`cat denpa-gardening/sensor_data/sensor_data.csv  | awk -F ',' '{if(m<$2)m=$2} END{print m;}'`
Mhumi=`cat denpa-gardening/sensor_data/sensor_data.csv  | awk -F ',' '{if(m<$3)m=$3} END{print m;}'`
Mpres=`cat denpa-gardening/sensor_data/sensor_data.csv  | awk -F ',' '{if(m<$4)m=$4} END{print m;}'`

mtemp=`cat denpa-gardening/sensor_data/sensor_data.csv  | awk -F ',' 'BEGIN{m=100000}{if(m>$2) m=$2} END{print m}'`
mhumi=`cat denpa-gardening/sensor_data/sensor_data.csv  | awk -F ',' 'BEGIN{m=100000}{if(m>$3) m=$3} END{print m}'`
mpres=`cat denpa-gardening/sensor_data/sensor_data.csv  | awk -F ',' 'BEGIN{m=100000}{if(m>$4) m=$4} END{print m}'`

echo ${time}, ${temp}, ${humi}, ${pres}, ${Mtemp}, ${Mhumi}, ${Mpres}, ${mtemp}, ${mhumi}, ${mpres} >> daily.csv

#generating graph
python makefigdaily.py daily.csv
#move image to web
mv daily.png /var/www/html
cp daily.csv /home/pi/share/kion
cp /var/www/html/sensor_data.png /home/pi/share/kion/sensor_data`date +"%Y%m%d%H%M"`.png
