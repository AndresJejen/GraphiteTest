IMAGE=test_andres_jejen_graphite
docker build -t $IMAGE .
docker run --env DB_HOST=$DB_HOST:5432  --name test --network host --rm $IMAGE