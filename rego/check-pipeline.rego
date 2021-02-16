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
  reason := "All pipelines must have a Stage 1 workflow 'Check OPA' that ensures OPA is running in the target Kubernetes environment."
}
