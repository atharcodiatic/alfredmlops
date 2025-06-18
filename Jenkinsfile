pipeline{
    environment { django_secret_key = credentials('django_secret_key')}
    agent any
    stages{
        stage('build with docker-compose'){
            steps {
                sh 'echo "Hello World"'
                sh  'sudo docker-compose build'
                sh 'sudo docker-compose up -d'

                script {timeout(time: 50, unit: 'SECONDS') {
                        waitUntil {
                            def result = sh(script: 'curl -s -o /dev/null -w "%{http_code}" http://localhost:8080', returnStdout: true).trim()
                            return result == '200'
                        }
                    }
                    }
                sh 'sudo docker-compose down'
            } 
        post{
            always{ echo 'build by dockerstage'}
        }
        }
        stage('build with k8s'){
            steps{
                script {
                    sh 'minikube start'
                    def applyYaml = { file ->
                        sh "kubectl apply -f ${file}"
                    }

                    applyYaml('ingress.yaml')
                    applyYaml('deployment.yaml')
                    applyYaml('web_deployment.yaml')

                    timeout(time: 50, unit: 'SECONDS'){

                    def build_status = sh (script: 'curl http://helpdesk.local', returnStatus:true)
                    if (build_status ==0){
                        echo 'service is ready'
                        archiveArtifacts artifacts: 'build_result.txt', fingerprint: true
                    } else{ echo " docker-compose deployment failed"}
                    }
            }
                sh 'kubectl delete deployments --all'
            
        }
        post {
                always { mail to: "athar110011@gmail.com",
                subject: " build results: ${currentBuild.result} ${stageResult}" ,
                body: "The Jenkins pipeline build has completed. Please review the details."
            }
            }
    }
}
}