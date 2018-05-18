#!/bin/bash
ET_SRC_URL=${ET_SRC_URL:-"http://dexya6d9gs5s.cloudfront.net/latest/dynatrace-easytravel-src.zip"}

ET_SRC_HOME=/tmp
ET_SRC_CF_HOME="${ET_SRC_HOME}/CustomerFrontend"
ET_SRC_BB_HOME="${ET_SRC_HOME}/BusinessBackend"
ET_SRC_LG_HOME="${ET_SRC_HOME}/com.dynatrace.uemload"

ET_DEPLOY_HOME="${ET_DEPLOY_HOME:-$(pwd)/deploy}"
ET_CF_DEPLOY_HOME="${ET_DEPLOY_HOME}/${ET_CF_DEPLOY_HOME:-frontend}"
ET_BB_DEPLOY_HOME="${ET_DEPLOY_HOME}/${ET_BB_DEPLOY_HOME:-backend}"
ET_LG_DEPLOY_HOME="${ET_DEPLOY_HOME}/${ET_LG_DEPLOY_HOME:-loadgen}"
ET_CF_DEPLOY_LIB_HOME="${ET_CF_DEPLOY_HOME}/lib"

cd "${ET_SRC_HOME}"

# Download easyTravel sources
curl -L -o easyTravel-src.zip "${ET_SRC_URL}"

# Unarchive and build easyTravel sources while setting up some env vars
unzip ./easyTravel-src.zip
export ANT_OPTS="-Dfile.encoding=UTF8"
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8
ant -f ./Distribution war
cd "${ET_SRC_HOME}/Distribution/dist"

# Deploy easyTravel build artifacts into the workspace
mkdir -p "${ET_BB_DEPLOY_HOME}"
cp -v ./business/backend.war ${ET_BB_DEPLOY_HOME}

mkdir -p "${ET_CF_DEPLOY_HOME}"
cp -v ./customer/frontend.war ${ET_CF_DEPLOY_HOME}

mkdir -p "${ET_LG_DEPLOY_HOME}"
tar -cvzf "${ET_LG_DEPLOY_HOME}/loadgen.tar.gz" \
          ./lib/commons-cli-*.jar \
          ./lib/commons-io-*.jar \
          ./lib/commons-lang*.jar \
          ./lib/commons-logging-*.jar \
          ./lib/guava-*.jar \
          ./lib/httpclient-*.jar \
          ./lib/httpcore-*.jar \
          ./lib/metrics-core-*.jar \
          ./lib/metrics-json-*.jar \
          ./lib/metrics-jvm-*.jar \
          ./lib/metrics-servlets-*.jar \
          ./lib/mvel*.jar \
          ./lib/nekohtml-*.jar \
          ./lib/xercesImpl-*.jar \
          ./lib/xml-apis-*.jar \
          ./resources/easyTravel.properties \
          ./resources/easyTravelConfig.properties \
          ./resources/easyTravelThirdPartyResourcesizes.properties \
          ./resources/Users.txt \
          ./com.dynatrace.easytravel.commons.jar \
          ./uemload.jar
