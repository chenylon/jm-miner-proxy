# 系统
echo 'fs.file-max = 655350' | sudo tee -a /etc/sysctl.conf
echo 'net.netfilter.nf_conntrack_max = 1048576' | sudo tee -a /etc/sysctl.conf
echo 'net.nf_conntrack_max = 1048576' | sudo tee -a /etc/sysctl.conf
echo 'ulimit -SHn 102400' | sudo tee -a /etc/profile

sudo sysctl -p

# 用户
sudo tee -a /etc/security/limits.conf << EOF
*               hard    nofile          65535
*               soft    nofile          65535
root            hard    nofile          65535
root            soft    nofile          65535
* 				soft 	nofile 			102400
* 				hard 	nofile 			102400
EOF

# Systemd
sudo tee -a /etc/systemd/system.conf << EOF
DefaultLimitCORE=infinity
DefaultLimitNOFILE=102400
DefaultLimitNPROC=102400
EOF

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
