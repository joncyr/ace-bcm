%define scala_version 2.10
%define mx4j_version 3.0.2

Name: kafka
Version: 0.8.2.1
Release: 2
Summary: Apache Kafka (built for Scala Version %{scala_version})
Group: Applications/Internet
License: Apache
URL: http://kafka.apache.org
Source0: http://apache.mirrors.hoobly.com/kafka/%{version}/kafka_%{scala_version}-%{version}.tgz
Source1: kafka.service
Source2: kafka.sysconfig
Source3: kafka-log4j.properties
Source4: mx4j-%{mx4j_version}.tar.gz
BuildRoot: %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

%description
Apache Kafka (built for Scala Version %{scala_version})

%prep
%setup -n kafka_%{scala_version}-%{version}

# This SPEC build is Only Packaging.
%build

%install
# Clean out any previous builds not on slash (lol)
[ "%{buildroot}" != "/" ] && %{__rm} -rf %{buildroot}

%{__mkdir_p} %{buildroot}/etc/kafka
%{__mkdir_p} %{buildroot}/etc/sysconfig
%{__mkdir_p} %{buildroot}/usr/lib/systemd/system
%{__mkdir_p} %{buildroot}/usr/share/kafka/bin
%{__mkdir_p} %{buildroot}/usr/share/kafka/libs
%{__mkdir_p} %{buildroot}/var/lib/kafka
%{__mkdir_p} %{buildroot}/var/log/kafka

%{__cp} %{SOURCE1}  %{buildroot}/usr/lib/systemd/system/kafka.service
%{__cp} %{SOURCE2}  %{buildroot}/etc/sysconfig/kafka
%{__cp} LICENSE     %{buildroot}/usr/share/kafka/
%{__cp} NOTICE      %{buildroot}/usr/share/kafka/
%{__cp} -R bin/*    %{buildroot}/usr/share/kafka/bin/
%{__cp} -R libs/*   %{buildroot}/usr/share/kafka/libs/
%{__cp} -R config/* %{buildroot}/etc/kafka/

# Override with our log4j.properties which just makes the log directory be /var/log/kafka
%{__rm} %{buildroot}/etc/kafka/log4j.properties
%{__cp} %{SOURCE3} %{buildroot}/etc/kafka/log4j.properties

# Include MX4J in our Kafka distribution
%{__tar} -xvzf %{SOURCE4}
%{__cp} -R mx4j-%{mx4j_version}/lib/* %{buildroot}/usr/share/kafka/libs/

%clean
[ "%{buildroot}" != "/" ] && %{__rm} -rf %{buildroot}

%pre
getent group kafka >/dev/null || groupadd -r kafka
getent passwd kafka >/dev/null || /usr/sbin/useradd --comment "Kafka Daemon User" --shell /bin/false -M -r -g kafka --home /var/lib/kafka kafka

%files
%defattr(644, root, root, 755)
%config /etc/kafka
%config /etc/sysconfig/kafka
%attr(755, -, -) /usr/share/kafka/bin/*
/usr/share/kafka/LICENSE
/usr/share/kafka/NOTICE
/usr/share/kafka/libs
/usr/lib/systemd/system/kafka.service
%attr(755, kafka, kafka) /var/lib/kafka
%attr(755, kafka, kafka) /var/log/kafka
