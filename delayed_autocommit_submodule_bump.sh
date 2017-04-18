#!/usr/bin/env bash
# This should be invoked by the pgadmin4/.git/hooks/pre-push hook
branch_name=$1
set -euxo pipefail
echo 'Resting before commit to pgadmin4-CI'

sleep 10

git pull -r

git submodule update --init

pushd submodules/plummaster
  git fetch
  git reset --hard origin/$branch_name
  CHILD_SHA=$(git rev-parse HEAD)
  CHILD_MESSAGE=$(git log --format=%B -n 1 HEAD)
popd

pushd submodules/master
  git fetch
  git reset --hard origin/master
  MASTER_CHILD_SHA=$(git rev-parse HEAD)
  MASTER_CHILD_MESSAGE=$(git log --format=%B -n 1 HEAD)
popd

git add submodules/plummaster
git add submodules/master
git commit -m "[$branch_name] Run tests for \"$CHILD_MESSAGE\"($CHILD_SHA)

- also bump master to \"$MASTER_CHILD_MESSAGE\"($MASTER_CHILD_SHA)"

git push

