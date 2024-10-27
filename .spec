Name:           simple-c
Version:        10.0.0
Release:        1%{?dist}

License:        GPLv3
URL:            https://github.com/Mila-githu/simple-c
Source:         %{name}-%{version}.tar.gz
BuildArch:      noarch

Requires:       bash, git, jq, unzip, tar

%description
A simple C program

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
install %{name} $RPM_BUILD_ROOT/%{_bindir}
mkdir -p $RPM_BUILD_ROOT/%{_sysconfdir}
install %{name}rc $RPM_BUILD_ROOT/%{_sysconfdir}
mkdir -p $RPM_BUILD_ROOT/%{_mandir}/man1/
install %{name}.1 $RPM_BUILD_ROOT/%{_mandir}/man1/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/%{name}
%{_sysconfdir}/%{name}rc
%doc %{_mandir}/man1/%{name}.1.*
%license LICENSE

%changelog
* Sun Oct 27 2024
- configured spec file for use with GitHub Actions to automate building of RPM

* Sun Oct 27 2024
- initial release
