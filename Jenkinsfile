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
                        echo 'Ejecución de pruebas de SAST'
                    }
                }

                stage('Imprimir Env') {
                    steps {
                        echo "El WORKSPACE es: ${env.WORKSPACE}"
                    }
                }

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