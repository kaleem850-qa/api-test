pipeline {
    agent any

    stages {
        stage('Run the tests') {
            steps {
                echo 'Running the test'
                sh 'mvn clean test'
            }
        }
        stage('publish report') {
            steps {
                echo 'Publishing the report'
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'target/cucumber-report', reportFiles: 'report.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
    }
}
