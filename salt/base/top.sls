#base:
#  '*':
    #- init.env_init
    #- apache
prod:
  'node02':
    - yum_lnmp.service
