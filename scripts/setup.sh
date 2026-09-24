cp .env.example .env

sudo mkdir -p \
  /var/lib/daggler-home/pihole \
  /var/lib/daggler-home/caddy/data \
  /var/lib/daggler-home/caddy/config \
  /var/lib/daggler-home/grafana \
  /var/lib/daggler-home/prometheus \
  /var/lib/daggler-home/portainer \
  /var/lib/daggler-home/plex/config \
  /var/lib/daggler-home/plex/transcode

sudo mkdir -p \
/srv/media/movies \
/srv/media/tv \
/srv/media/music \
/srv/media/photos

sudo mkdir -p /etc/daggler-home/secrets

openssl rand -base64 24 | \
sudo tee /etc/daggler-home/secrets/pihole_admin_password >/dev/null

openssl rand -base64 24 | \
sudo tee /etc/daggler-home/secrets/grafana_admin_password >/dev/null

sudo chmod 600 /etc/daggler-home/secrets/*
