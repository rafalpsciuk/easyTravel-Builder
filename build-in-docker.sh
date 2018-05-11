DOCKER_CONTAINER_BUILD_SH_PREFIX=${DOCKER_CONTAINER_BUILD_SH_PREFIX:-.}
DOCKER_CONTAINER_WORKDIR=/workspace

if [ ! -z "${ET_DEPLOY_HOME}" ]; then
  # Make sure that ET_DEPLOY_HOME gets a location inside the user's current working
  # directory, which gets mounted into as the Docker container's DOCKER_CONTAINER_WORKDIR.
  ET_DEPLOY_HOME="${DOCKER_CONTAINER_WORKDIR}/${ET_DEPLOY_HOME}"
fi

docker run --rm \
  --volume "$(pwd):${DOCKER_CONTAINER_WORKDIR}" \
  --env ET_SRC_URL="${ET_SRC_URL}" \
  --env ET_DEPLOY_HOME="${ET_DEPLOY_HOME}" \
  --env ET_BB_DEPLOY_HOME="${ET_BB_DEPLOY_HOME}" \
  --env ET_CF_DEPLOY_HOME="${ET_CF_DEPLOY_HOME}" \
  --env ET_LG_DEPLOY_HOME="${ET_LG_DEPLOY_HOME}" \
  frekele/ant \
  "${DOCKER_CONTAINER_WORKDIR}/${DOCKER_CONTAINER_BUILD_SH_PREFIX}/build.sh"
