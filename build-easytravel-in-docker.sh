DOCKER_WORKDIR=/workspace

if [ ! -z "${ET_BUILD_HOME}" ]; then
  # Make sure that ET_BUILD_HOME gets a location inside the user's current working
  # directory, which gets mounted into as the Docker container's DOCKER_WORKDIR.
  ET_BUILD_HOME="${DOCKER_WORKDIR}/${ET_BUILD_HOME}"
fi

docker run --rm \
  --volume "$(pwd):${DOCKER_WORKDIR}" \
  --env ET_SRC_URL="${ET_SRC_URL}" \
  --env ET_BUILD_HOME="${ET_BUILD_HOME}" \
  --env ET_BB_BUILD_HOME="${ET_BB_BUILD_HOME}" \
  --env ET_CF_BUILD_HOME="${ET_CF_BUILD_HOME}" \
  --env ET_LG_BUILD_HOME="${ET_LG_BUILD_HOME}" \
  monostream/apache-ant \
  ./build-easytravel.sh