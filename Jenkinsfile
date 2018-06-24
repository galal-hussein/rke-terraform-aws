node {

  checkout scm

  stage ('Terraform Apply') {
    sh "./scripts/apply"
  }

  stage ('RUN Kubectl') {
      sh "kubectl --kubeconfig=kube_config_rke.yml apply -f job.yml"
      sh "sleep 30"
      sh "kubectl --kubeconfig=kube_config_rke.yml get jobs"
  }

  stage ('Terraform Destroy') {
    sh "./scripts/destroy"
  }
}
