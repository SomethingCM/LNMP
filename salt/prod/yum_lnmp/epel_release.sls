repo_release:
  pkg.installed:
#    - names:
#      - epel-release 
####社区
#    - source:
#      -epel-release: http://mirrors.kernel.org/fedora-epel/epel-release-latest-7.noarch.rpm
#      - unless: rpm -qa | grep epel-release-7-5.noarch
###阿里
    - sources:
      - epel-release: http://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm
    - unless: rpm -qa | grep epel-release-7-5
