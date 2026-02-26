pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Descargando código del repositorio...'
                checkout scm
            }
        }

        stage('Pruebas de SAST') {
            steps {
                echo 'Ejecución de pruebas de SAST'
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