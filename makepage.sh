#!/bin/bash

API_KEY=$(cat apikey)

curl http://api.wunderground.com/api/$API_KEY/forecast/q/TX/Austin.xml > forecast.xml

HIGH=$(xmlstarlet sel -t -v '//response/forecast/simpleforecast/forecastdays/forecastday[1]/high/fahrenheit' forecast.xml)
LOW=$(xmlstarlet sel -t -v '//response/forecast/simpleforecast/forecastdays/forecastday[1]/low/fahrenheit' forecast.xml)
CONDITION=$(xmlstarlet sel -t -v '//response/forecast/simpleforecast/forecastdays/forecastday[1]/conditions' forecast.xml)
ICON_URL=$(xmlstarlet sel -t -v '//response/forecast/simpleforecast/forecastdays/forecastday[1]/icon_url' forecast.xml)

curl http://api.wunderground.com/api/$API_KEY/conditions/q/TX/Austin.xml > conditions.xml
CURRENT=$(xmlstarlet sel -t -v '//response/current_observation/temp_f' conditions.xml)

cat <<EOF >> data.json
{
  "high": $HIGH,
  "low": $LOW,
  "current": $CURRENT,
  "condition": "$CONDITION",
  "icon_url": "$ICON_URL"
}
EOF

curl -s http://api.wunderground.com/api/$API_KEY/hourly/q/TX/Austin.json > hourly.json
grep '"hour"' hourly.json|sed "s/,.*//"|tr -d '"'|awk '{print $2}'|nl > times.txt
grep '"temp"' hourly.json|tr -d '"'|tr -d ','|awk '{print $3}'|nl > t.txt
join times.txt t.txt|cut -d' ' -f 2,3 |awk '{if ($1 > 0) print $1,$2; else exit}' |head -14 > data.txt
gnuplot -e "filename='data.txt'" bar.plg
