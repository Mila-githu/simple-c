
Name:           file-counter
Version:        1.0
Release:        1%{?dist}
Summary:        A script to count files in /etc

License:        GPL
Source0:        file-counter.sh

%description
This package provides a script that counts files in the /etc directory, excluding directories and symlinks.

%prep
# No preparation required

%build
# No build required

%install
install -d %{buildroot}/usr/local/bin
install -m 0755 %{SOURCE0} %{buildroot}/usr/local/bin/file-counter.sh

%files
/usr/local/bin/file-counter.sh

%changelog
* Tue Sep 24 2024 Your Name <your.email@example.com> 1.0-1
- Initial package
