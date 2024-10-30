pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                git url: 'https://github.com/Mila-githu/simple-c.git', credentialsId: '0c98cf49-40a4-4578-9bb5-3f079a68b616'
            }
        }

        stage('Build RPM and DEB') {
            steps {
                sh '''
                sudo apt-get update
                sudo apt-get install -y rpm dpkg-dev build-essential

                # Prepare RPM structure
                mkdir -p $WORKSPACE/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
                cp file-counter.sh $WORKSPACE/rpmbuild/SOURCES/
                rpmbuild -ba --define "_topdir $WORKSPACE/rpmbuild" file-counter.spec

                # Prepare DEB structure
                mkdir -p file-counter-1.0/usr/local/bin
                cp file-counter.sh file-counter-1.0/usr/local/bin/
                chmod 755 file-counter-1.0/usr/local/bin/file-counter.sh
                mkdir -p file-counter-1.0/DEBIAN
                echo "Package: file-counter" > file-counter-1.0/DEBIAN/control
                echo "Version: 1.0" >> file-counter-1.0/DEBIAN/control
                echo "Section: base" >> file-counter-1.0/DEBIAN/control
                echo "Priority: optional" >> file-counter-1.0/DEBIAN/control
                echo "Architecture: all" >> file-counter-1.0/DEBIAN/control
                echo "Maintainer: Your Name <your.email@example.com>" >> file-counter-1.0/DEBIAN/control
                echo "Description: A script to count files in /etc excluding directories and symlinks" >> file-counter-1.0/DEBIAN/control
                dpkg-deb --build file-counter-1.0
                '''
            }
        }

        stage('Test RPM and DEB') {
            steps {
                sh '''
                # Install and test RPM
                sudo rpm -ivh $WORKSPACE/rpmbuild/RPMS/x86_64/file-counter-1.0-1.x86_64.rpm || true
                sudo dpkg -i file-counter-1.0.deb || true

                # Run the script to test its functionality
                /usr/local/bin/file-counter.sh
                '''
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: 'file-counter-1.0.deb, $WORKSPACE/rpmbuild/RPMS/x86_64/file-counter-1.0-1.x86_64.rpm', allowEmptyArchive: true
        }
    }
}
