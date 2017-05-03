#!/bin/sh

#get data
python /home/pi/denpa-gardening/get_sensor_data.py >> ./denpa-gardening/sensor_data/sensor_data.csv

#preparing html file
time=`tail -n 1 denpa-gardening/sensor_data/sensor_data.csv | awk -F ',' '{print $1}'`
temp0=`tail -n 1 denpa-gardening/sensor_data/sensor_data.csv | awk -F ',' '{print $2}'`
humi0=`tail -n 1 denpa-gardening/sensor_data/sensor_data.csv | awk -F ',' '{print $3}'`
pres0=`tail -n 1 denpa-gardening/sensor_data/sensor_data.csv | awk -F ',' '{print $4}'`
temp=`echo "scale=1; ${temp0}/1" | bc`
humi=`echo "scale=1; ${humi0}/1" | bc`
pres=`echo "scale=1; ${pres0}/1" | bc`

echo "<html>
<head>
    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" >
    <meta charset=\"UTF-8\" >
    <title>気温・湿度・気圧</title>
</head>
<body>
    <SCRIPT LANGUAGE=\"JavaScript\">
    <!--\nsetTimeout(\"location.reload()\",1000*60);-->
    </SCRIPT>
    <h1>気温<font color=\"red\">${temp}</font>℃・湿度<font color=\"blue\">${humi}</font>％・気圧<font color=\"green\">${pres}</font>hPa(${time})</h1>
    <img src=\"sensor_data.png\" width=\"50%\"><img src=\"daily.png\" width=\"50%\">
</body>
</html>" > /var/www/html/index.html
