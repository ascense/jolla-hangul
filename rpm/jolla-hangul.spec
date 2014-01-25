Name: jolla-hangul
Version: 0.01
Release: 1%{?dist}
Summary: Hangul layout and input method for Sailfish OS
License: LGPLv2
Source: %{name}-%{version}.tar.gz
URL: https://github.com/Ascense/jolla-hangul
Requires:   jolla-keyboard
Requires:   jolla-xt9

%description
Allows you to type in Hangul on Sailfish OS.

%define debug_package %{nil}

%prep
%setup -q

%build
# do nothing

%install
#rm -rf %{buildroot}
#make install DESTDIR=%{buildroot}
mkdir -p %{buildroot}/usr/share/maliit/plugins/com/jolla/layouts/
cp -r src/kr_hangul* %{buildroot}/usr/share/maliit/plugins/com/jolla/layouts/

%clean
rm -rf %{buildroot}

%files
/usr/share/maliit/plugins/com/jolla/layouts/kr_hangul.qml
/usr/share/maliit/plugins/com/jolla/layouts/kr_hangul.conf
/usr/share/maliit/plugins/com/jolla/layouts/kr_hangul/KrInputHandler.qml
/usr/share/maliit/plugins/com/jolla/layouts/kr_hangul/parse_jamo.js
