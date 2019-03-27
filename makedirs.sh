# Make all these fucking directories

sudo mkdir -p ./dockerdata

sudo mkdir -p ./dockerdata/prometheus
sudo mkdir -p ./dockerdata/elasticsearch/data
sudo mkdir -p ./dockerdata/elastalert/logs
sudo mkdir -p ./dockerdata/alertmanager/data
sudo mkdir -p ./dockerdata/grafana
sudo mkdir -p ./dockerdata/curator

sudo mkdir -p ./dockerdata/elastalert/config

sudo mkdir -p ./dockerdata/elastalert/rules
sudo mkdir -p ./dockerdata/elastalert/logs


sudo mkdir -p ./dockerdata/prometheus/data
sudo mkdir -p ./dockerdata/prometheus/rules
sudo chmod 777 ./dockerdata/prometheus/data


cd configs

sudo cp alertmanagerconfig.yml ../dockerdata/alertmanager
sudo cp elastalert_supervisord.conf ../dockerdata/elastalert/config
sudo cp elastalertconfig.yaml ../dockerdata/elastalert/config	
sudo cp prometheus.yml ../dockerdata/prometheus
sudo touch ../dockerdata/prometheus/rules/alertrules.nodes
sudo touch ../dockerdata/prometheus/rules/alertrules.task
sudo touch ../dockerdata/elastalert/rules/elastrules.error.yaml
sudo touch ../dockerdata/curator/action.yml
cd ..

# Move it to var on the server...
sudo mv dockerdata/ /var

# create your networks
docker network create -d overlay monitoring
docker network create -d overlay logging



docker stack deploy -c composefiles/docker-compose-logging.yml logging

docker stack deploy -c composefiles/docker-compose-monitoring.yml monitoring
