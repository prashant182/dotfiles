#!/bin/bash

# Turn off local Time Machine snapshots [laptops only]
sudo tmutil disablelocal

# Turn off hibernation [laptops only]
sudo pmset -a hibernatemode 0
sudo command rm /var/vm/sleepimage

# Turn off sudden motion sensor [no HDD only]
sudo pmset -a sms 0

# Disable records last access time for every file
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.nullvision.noatime</string>
    <key>ProgramArguments</key>
    <array>
      <string>mount</string>
      <string>-vuwo</string>
      <string>noatime</string>
      <string>/</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>' | sudo tee /Library/LaunchDaemons/com.nullvision.noatime.plist
sudo chown root:wheel /Library/LaunchDaemons/com.nullvision.noatime.plist

# Delay (180 minutes) hard drive sleep [no HDD only]
sudo pmset -b disksleep 180  # Battery
sudo pmset -c disksleep 180  # Power adapter


echo
echo "For changes to take effect, restart your computer!"
