node {

  checkout scm

  stage ('Terraform Apply') {
    sh "./scripts/apply"
  }

  stage ('RUN Kubectl') {
      sh "echo \"${JOB_YAML}\" > job.yml"
      sh "kubectl --kubeconfig=kube_config_rke.yml apply -f job.yml"
      sh "sleep 120"
  }

  stage ('Terraform Destroy') {
    sh "./scripts/destroy"
}
