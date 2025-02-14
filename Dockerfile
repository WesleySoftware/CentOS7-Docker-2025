FROM docker.io/centos:centos7
# Remove the default repo file
RUN rm /etc/yum.repos.d/CentOS-Base.repo
# Copy repo files
COPY CentOS-Vault.repo /etc/yum.repos.d/
COPY CentOS-SCLo-scl.repo /etc/yum.repos.d/
COPY CentOS-SCLo-rh.repo /etc/yum.repos.d/
COPY EPEL-Vault.repo /etc/yum.repos.d/
# Import GPG keys
RUN curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo https://www.centos.org/keys/RPM-GPG-KEY-CentOS-SIG-SCLo
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo
# Add EPEL GPG key
RUN curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 https://archive.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
# Clean and make cache
RUN yum clean all && yum makecache
#update
RUN yum update -y
#Fix the repo files again
RUN rm /etc/yum.repos.d/CentOS-Base.repo
# Copy repo files
COPY CentOS-Vault.repo /etc/yum.repos.d/
COPY CentOS-SCLo-scl.repo /etc/yum.repos.d/
COPY CentOS-SCLo-rh.repo /etc/yum.repos.d/
COPY EPEL-Vault.repo /etc/yum.repos.d/
# Import GPG keys
RUN curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo https://www.centos.org/keys/RPM-GPG-KEY-CentOS-SIG-SCLo
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo
# Add EPEL GPG key again after repo reset
RUN curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 https://archive.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
# Clean and make cache
RUN yum clean all && yum makecache