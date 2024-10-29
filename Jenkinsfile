pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/Mila-githu/file-counter.git'
            }
        }

        stage('Build RPM and DEB') {
            steps {
                sh '''
                sudo apt-get update
                sudo apt-get install rpm dpkg-dev build-essential -y
                mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
                cp count_files.sh ~/rpmbuild/SOURCES/
                rpmbuild -ba file-counter.spec
                mkdir -p file-counter-1.0/usr/local/bin
                cp count_files.sh file-counter-1.0/usr/local/bin/
                chmod 755 file-counter-1.0/usr/local/bin/count_files.sh
                mkdir -p file-counter-1.0/DEBIAN
                echo "Package: file-counter" > file-counter-1.0/DEBIAN/control
                dpkg-deb --build file-counter-1.0
                '''
            }
        }

        stage('Test RPM and DEB') {
            steps {
                sh '''
                sudo rpm -ivh ~/rpmbuild/RPMS/x86_64/file-counter-1.0-1.x86_64.rpm || true
                sudo dpkg -i file-counter-1.0.deb || true
                /usr/local/bin/count_files.sh
                '''
            }
        }
    }
}
