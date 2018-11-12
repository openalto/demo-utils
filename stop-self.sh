sudo kill -9 $(ps aux | grep karaf | awk '{print $2}')
sudo kill -9 $(ps aux | grep gunicorn | awk '{print $2}')
sudo kill -9 $(ps aux | grep jetty | awk '{print $2}')