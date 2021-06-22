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

flutter run --enable-software-renderin