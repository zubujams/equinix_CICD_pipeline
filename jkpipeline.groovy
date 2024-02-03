pipeline {
    agent any

    tools {
        // Ensure Maven and JDK are configured in Jenkins' Global Tool Configuration
        maven 'Maven_3_8_1' // The name of your Maven installation in Jenkins
        jdk 'OpenJDK_11'    // The name of your JDK installation in Jenkins
    }
stages {
        stage('Checkout Code') {
            steps {
                // Checks out the project from GitHub
                checkout scm
            }
        }

        stage('Build') {
            steps {
                // Builds the project with Maven
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Runs tests with Maven
                sh 'mvn test'
            }
        }

        // This new stage triggers an Ansible playbook
        stage('Run Ansible Playbook') {
            steps {
                // Running an Ansible playbook
                // Ensure ansible or ansible-playbook is available in the PATH on the Jenkins agent
                sh 'ansible-playbook -i /path/to/inventory /path/to/playbook.yml'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                // Add deployment steps here
            }
        }
    }

    post {
        always {
            // Clean up workspace after the pipeline runs
            cleanWs()
        }
    }
}
