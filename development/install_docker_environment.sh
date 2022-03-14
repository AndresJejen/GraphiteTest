#!/bin/bash -e
set -e

REPO_ROOT_DIR="$(git rev-parse --show-toplevel)"
# Generate Dockerfile for build.
cat "${REPO_ROOT_DIR}"/development/Dockerfile.development > "${REPO_ROOT_DIR}"/development/Dockerfile.build

IMAGE="alpine:latest"
PORT=5050

APP_NAME=$(echo ${PWD##*/} | awk '{print tolower($0)}')
echo "APP_NAME = $APP_NAME"

sed -i -r "s/IMAGE/$IMAGE/" "${REPO_ROOT_DIR}"/development/Dockerfile.build
docker build -t andresjejen/$APP_NAME -f "${REPO_ROOT_DIR}"/development/Dockerfile.build .

docker run -it -v ${PWD}:/app -w /app -d -p ${PORT}:5000 --name andresjejen_$APP_NAME andresjejen/$APP_NAME
rm "${REPO_ROOT_DIR}"/development/Dockerfile.build
echo "Environment succesfully mounted, now use VS CODE to edit inside your docker app..."
echo "Happy Hacking ☺️"