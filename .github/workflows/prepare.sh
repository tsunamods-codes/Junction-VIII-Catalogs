#!/bin/bash

if [[ "$_BUILD_BRANCH" == "refs/heads/master" || "$_BUILD_BRANCH" == "refs/tags/canary" ]]; then
  export _IS_BUILD_CANARY="true"
  export _IS_GITHUB_RELEASE="true"
elif [[ "$_BUILD_BRANCH" == refs/tags/* ]]; then
  _BUILD_VERSION="${_BUILD_VERSION%.*}.0"
  export _IS_GITHUB_RELEASE="true"
fi

export _RELEASE_VERSION="v${_BUILD_VERSION}"

echo "--------------------------------------------------"
echo "RELEASE VERSION: $_RELEASE_VERSION"
echo "--------------------------------------------------"

echo "_BUILD_VERSION=${_BUILD_VERSION}" >> $GITHUB_ENV
echo "_RELEASE_VERSION=${_RELEASE_VERSION}" >> $GITHUB_ENV
echo "_IS_BUILD_CANARY=${_IS_BUILD_CANARY}" >> $GITHUB_ENV
echo "_IS_GITHUB_RELEASE=${_IS_GITHUB_RELEASE}" >> $GITHUB_ENV