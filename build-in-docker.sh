DOCKER_WORKDIR=/workspace

if [ ! -z "${ET_DEPLOY_HOME}" ]; then
  # Make sure that ET_DEPLOY_HOME gets a location inside the user's current working
  # directory, which gets mounted into as the Docker container's DOCKER_WORKDIR.
  ET_DEPLOY_HOME="${DOCKER_WORKDIR}/${ET_DEPLOY_HOME}"
fi

docker run --rm \
  --volume "$(pwd):${DOCKER_WORKDIR}" \
  --env ET_SRC_URL="${ET_SRC_URL}" \
  --env ET_DEPLOY_HOME="${ET_DEPLOY_HOME}" \
  --env ET_BB_DEPLOY_HOME="${ET_BB_DEPLOY_HOME}" \
  --env ET_CF_DEPLOY_HOME="${ET_CF_DEPLOY_HOME}" \
  --env ET_LG_DEPLOY_HOME="${ET_LG_DEPLOY_HOME}" \
  monostream/apache-ant \
  ./build.sh