/home/deploy/dekoruje.com/log/*.log {
  daily
  missingok
  rotate 30
  compress
  delaycompress
  copytruncate
}
