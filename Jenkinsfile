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
                            // Inyecta SonarQube como variables de entorno
                            withSonarQubeEnv('Sonar Local') {
                                // Ejecuta el análisis
                                sh 'sonar-scanner -Dsonar.projectKey=devops-webserver -Dsonar.sources=src'
                            }

                            // Espera el resultado del Quality Gate, sin abortar el pipeline
                            timeout(time: 10, unit: 'MINUTES') {
                                waitForQualityGate abortPipeline: false
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

    }
}