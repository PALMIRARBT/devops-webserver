pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Descargando código del repositorio...'
                checkout scm
            }
        }

        stage('Pruebas en Paralelo') {
            parallel {

                stage('Pruebas de SAST') {
                    steps {
                        script {
                            withSonarQubeEnv('Sonar Local') {
                                sh 'sonar-scanner -Dsonar.projectKey=devops-webserver -Dsonar.sources=src'
                            }
                        }
                    }
                }

                stage('Imprimir Env') {
                    steps {
                        echo "El WORKSPACE es: ${env.WORKSPACE}"
                    }
                }

            }
        }

        stage('Configurar archivo') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'Credentials_DevOps',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh '''
                        echo "[credentials]" > credentials.ini
                        echo "user=$USER" >> credentials.ini
                        echo "password=$PASS" >> credentials.ini
                    '''
                }

                archiveArtifacts artifacts: 'credentials.ini', fingerprint: true
            }
        }

        stage('Build') {
            steps {
                echo 'Construyendo imagen Docker...'
                sh 'docker build -t devops_ws .'
            }
        }

        stage('Despliegue del servidor') {
            steps {
                echo 'Deteniendo contenedor anterior si existe...'
                sh 'docker stop devops_ws || true'
                sh 'docker rm devops_ws || true'

                echo 'Levantando nuevo contenedor...'
                sh 'docker run -d -p 8090:8090 --name devops_ws devops_ws'
            }
        }

    }
}