# !/bin/bash

echo "changing navbar"
adb shell cmd overlay disable com.samsung.internal.systemui.navbar.gestural_no_hint
adb shell cmd overlay enable com.android.internal.systemui.navbar.threebutton
echo "opening scrcpy"
scrcpy --always-on-top -m 700
echo "changin navbar back"
adb shell cmd overlay disable com.android.internal.systemui.navbar.threebutton
adb shell cmd overlay enable com.samsung.internal.systemui.navbar.gestural_no_hint
