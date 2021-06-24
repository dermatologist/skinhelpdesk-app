* F5 to run in debug mode

## Android SDK commandline installation

 After unzipping the command line tools package, the top-most directory you'll get is cmdline-tools. Rename the unpacked directory from cmdline-tools to tools, and place it under /home/user/Android/cmdline-tools

now it will look like $C:/Android/cmdline-tools/tools (Windows)

and it will work perfectly.


## Create platform

sdkmanager "platform-tools" "platforms;android-29" "build-tools;29.0.3"

sdkmanager --install "system-images;android-29;default;x86_64"

avdmanager create avd -n default_avd -k "system-images;android-29;default;x86_64"

## Emulator
emulator -avd default_avd -no-audio -no-accel -gpu auto

flutter run --enable-software-rendering

flutter run --enable-software-rendering -d web-server

## Good references
* https://gist.github.com/mrk-han/66ac1a724456cadf1c93f4218c6060ae
* https://gist.github.com/badsyntax/4029600db276b0b51342626aebf9400a

echo "no" | avdmanager --verbose create avd --force --name "generic_4.4" --package "system-images;android-30;google_apis;x86" --tag "google_apis" --abi "x86"

emulator @generic_4.4 -no-boot-anim -netdelay none -no-snapshot -wipe-data -skin 768x1280 -no-audio -no-accel -gpu auto

emulator -avd Pixel_API_29_AOSP -no-snapshot -no-audio -no-boot-anim -camera-back none -camera-front none -no-accel -gpu auto

emulator -avd Pixel_API_29_AOSP -no-audio -no-boot-anim -camera-front none -no-accel -gpu auto


## GM
adb (dis)connect IP:5555