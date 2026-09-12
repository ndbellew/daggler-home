bash scripts/bootstrap.sh
cd ..
docker compose up --build -d
cd scripts
bash configure-network.sh
cd ..
docker compose logs -f --tail=20