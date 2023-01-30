#!/usr/bin/env bash

set -o errexit  # stop on first error
set -o xtrace  # log every step
set -o nounset  # exit when script tries to use undeclared variables

export GITLAB_URL="http://localhost"
export GITLABRUNNER_USER="<pipeline_user>"
export BUILD_DIRECTORY="/build"