package harness.pipeline

deny[reason] {

  # We will be looking for types of PIPELINE
  type := input.type
 
  # We will be looking for Stage 1 workflowName != Check OPA
  stage1_workflowName := input.pipelineStages[0].workflowName
  
  # Now the checkfor type = PIPELINE and workflowName != Check OPA
  type == "PIPELINE"
  stage1_workflowName != "Check OPA"

  # Set the deny message
  reason := sprintf("All pipeline Stage 1 workflow names should be 'Check OPA' but found ''%v'",[stage1_workflowName])
  
}
allow[reason] {

  # We will be looking for types of PIPELINE
  type := input.type
 
  # We will be looking for Stage 1 workflowName != Check OPA
  stage1_workflowName := input.pipelineStages[0].workflowName
  
  # Now the checkfor type = PIPELINE and workflowName != Check OPA
  type == "PIPELINE"
  stage1_workflowName == "Check OPA"

  # Set the deny message
  reason := "Pipeline Stage 1 workflow name matches 'Check OPA'"
  
}
