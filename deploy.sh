eval $(aws ecr get-login --no-include-email)
docker build . -t cuecast-api 
docker tag cuecast-api:latest 312385566054.dkr.ecr.ca-central-1.amazonaws.com/cuecast-api:v1.0.0
docker push  312385566054.dkr.ecr.ca-central-1.amazonaws.com/cuecast-api:v1.0.0


