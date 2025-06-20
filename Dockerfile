FROM docker.io/centos:centos7


COPY *.repo /etc/yum.repos.d/

RUN set -eux; \
    rm -f /etc/yum.repos.d/CentOS-Base.repo; \
    \
    curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo https://www.centos.org/keys/RPM-GPG-KEY-CentOS-SIG-SCLo; \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo; \
    \
    curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 https://archive.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7; \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7; \
    \
    yum clean all; \
    yum makecache; \
    \
    yum update -y; \
    \
    rm -f /etc/yum.repos.d/CentOS-Base.repo; \
    \
    yum clean all