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
                sudo apt-get install -y rpm dpkg-dev build-essential

                # Prepare RPM structure
                mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
                cp count_files.sh ~/rpmbuild/SOURCES/
                chmod +x ~/rpmbuild/SOURCES/file-counter.sh  # Ensure executable
                rpmbuild -ba file-counter.spec

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
                sudo rpm -ivh ~/rpmbuild/RPMS/x86_64/file-counter-1.0-1.x86_64.rpm || true
                sudo dpkg -i file-counter-1.0.deb || true

                # Run the script to test its functionality
                /usr/local/bin/file-counter.sh
                '''
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: 'file-counter-1.0.deb, ~/rpmbuild/RPMS/x86_64/file-counter-1.0-1.x86_64.rpm', allowEmptyArchive: true
        }
    }
}
