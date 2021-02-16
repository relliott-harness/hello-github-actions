#!/bin/bash

printf "\n\n"
echo "# Open Policy Agent on event"
echo $EVENT_BEFORE
/opa version
printf "\n\n"

IFS=';'
mapfile -t lines < <(echo "$INPUT_TESTS" | grep -v "^$")

e_code=1
for line in "${lines[@]}"; do
  read -r -a args <<< "$line"
#  cmd="/opa test ${args[@]} $INPUT_OPTIONS"
  cmd="/opa eval -f values -i ./rego/mypipeline.yaml -d ./rego/check-pipeline.rego \"data.harness.pipeline.deny\""
  echo " 🚀 Running: $cmd"
  printf "\n"
  #eval "$cmd" || e_code=1
  export OPA_EVAL=`/opa eval -f values -i ./rego/mypipeline.yaml -d ./rego/check-pipeline.rego "data.harness.pipeline.deny"`
  echo $OPA_EVAL
  export DENY=`echo $OPA_EVAL | grep -P "All pipeline Stage 1 workflow names should be" -o`
  if [[ $DENY = "All pipeline Stage 1 workflow names should be" ]]
  then
      e_code = 1
  else
      e_code = 0
  fi
  printf "\n\n"
done

exit $e_code
