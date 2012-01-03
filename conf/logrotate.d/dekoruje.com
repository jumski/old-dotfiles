/home/deploy/dekoruje.com/log/*.log {
  missingok
  rotate 5
  compress
  delaycompress
  copytruncate
  size=1024k
  mail jumski@gmail.com
}
