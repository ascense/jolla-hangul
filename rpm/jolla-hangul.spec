Name: jolla-hangul
Version: 0.2
Release: 1%{?dist}
Summary: Korean input method for Sailfish OS
License: LGPLv2+
Source: %{name}-%{version}.tar.gz
URL: https://github.com/Ascense/jolla-hangul
Requires:   jolla-keyboard
Requires:   jolla-xt9

%description
Korean input method and virtual keyboard layout for Sailfish OS.

%define debug_package %{nil}

%prep
%setup -q

%build
# do nothing

%install
#rm -rf %{buildroot}
#make install DESTDIR=%{buildroot}
mkdir -p %{buildroot}/usr/share/maliit/plugins/com/jolla/layouts/
cp -r src/ko_hangul* %{buildroot}/usr/share/maliit/plugins/com/jolla/layouts/

%post
su nemo -c "/bin/systemctl --user restart maliit-server.service"

%postun
su nemo -c "/bin/systemctl --user restart maliit-server.service"

%clean
rm -rf %{buildroot}

%files
/usr/share/maliit/plugins/com/jolla/layouts/ko_hangul.qml
/usr/share/maliit/plugins/com/jolla/layouts/ko_hangul.conf
/usr/share/maliit/plugins/com/jolla/layouts/ko_hangul/KoInputHandler.qml
/usr/share/maliit/plugins/com/jolla/layouts/ko_hangul/KoSpacebarRow.qml
/usr/share/maliit/plugins/com/jolla/layouts/ko_hangul/parser.js
