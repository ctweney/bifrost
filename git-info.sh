#!/bin/bash
# writes git commit information to file. Used by ServerRuntime.

COMMIT=`git log --pretty=format:'%H' -n 1`
DATE=`git log --pretty=format:'%ad' -n 1`
echo "{\"git_commit\":\"$COMMIT\",\"git_commit_date\":\"$DATE\"}" > git.json
