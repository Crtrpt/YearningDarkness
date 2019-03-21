pipeline {
    agent any
    stages {
        stage('Build') {
            agent any
            steps {
                sh 'npm -v'
                sh '#cd webpage && npm install && npm run build'
                 sh 'cp  /root/.ssh/known_hosts /root/.ssh/known_hosts.bak'
                 sh 'rm  /root/.ssh/known_hosts'
                sh 'tar -czvf release.tgz src webpage/dist'
            }
        }
        stage('Transfer') {
            agent any
            steps {
            echo 'ssh -p 10033 root@172.17.110.113 "sh echo test>/roor/test"'
                sh 'scp -P 10033 release.tgz  root@172.17.110.113:/tmp'
                sh 'ssh -p 10033 root@172.17.110.113 "mkdir -p /var/www/yearning"'
                sh 'ssh -p 10033 root@172.17.110.113 "tar -zxvf /tmp/release.tgz -C /var/www/yearning"'
            }
        }
        stage('Deploy') {
            agent any
            steps {
                echo 'ssh -p 10033 root@172.17.110.113 "sh -x python manage.py runserver 0.0.0.0:8088"'
            }
        }
    }
    post {
        success {
            echo "success"
        }
        failure {
            echo "fail"
        }
        unstable {
            echo "unstable"
        }
        aborted {
            echo "aborted"
        }
    }
}