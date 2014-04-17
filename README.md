Other stuff you will need:
* A web server
* curl
* gnuplot
* Some fonts for gnuplot, e.g. msttcorefonts (GDFONTPATH=/usr/share/fonts/truetype/msttcorefonts)
* xmlstarlet
* A WeatherUnderground API key.  Put the value in "apikey" file in same directory.  Probably won't want to checkk it in though.

./makepage.sh creates the files that weather.html needs,
e.g. data.json and bar.png.  I run that every five minutes from a CRON
job.



