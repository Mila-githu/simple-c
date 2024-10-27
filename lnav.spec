Name:          lnav
Version:       0.11.1
Release:       1%{?dist}
Summary:       Curses-based tool for viewing and analyzing log files
License:       BSD
 
URL:           http://lnav.org
Source0:       https://github.com/tstack/lnav/releases/download/v%{version}/%{name}-%{version}.tar.bz2
 
BuildRequires: bzip2-devel
BuildRequires: gcc-c++
BuildRequires: libarchive-devel
BuildRequires: libcurl-devel
BuildRequires: make
BuildRequires: ncurses-devel
BuildRequires: openssh
BuildRequires: openssl-devel
BuildRequires: pcre2-devel
BuildRequires: readline-devel
BuildRequires: sqlite-devel
BuildRequires: zlib-devel
 
%description
%{name} is an enhanced log file viewer.
 
 
%prep
%setup -q
 
%build
%configure --disable-static --disable-silent-rules
%make_build
%install
%make_install
 
%files
%doc AUTHORS NEWS.md README.md
%license LICENSE
%{_bindir}/%{name}
%{_mandir}/man1/%{name}.1*
