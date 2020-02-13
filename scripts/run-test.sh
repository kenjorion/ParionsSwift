#!/bin/sh
if [[ "${TRAVIS_BRANCH}" == "master"  && "${TRAVIS_PULL_REQUEST}" != "false" ]]; then
  echo "This is a pull request on master";
elif [["${TRAVIS_PULL_REQUEST}" != "false" ]]; then
  fastlane ios commitformerge
  exit 0
fi
