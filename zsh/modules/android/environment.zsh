export ANDROID_SDK_HOME="$HOME/.android-sdk"
export PATH="$PATH:$ANDROID_SDK_HOME/cmdline-tools/bin:$ANDROID_SDK_HOME/emulator"

if [[ -n "$ANDROID_BUILD_TOOLS_VERSION" ]]; then
    export PATH="$PATH:$ANDROID_SDK_HOME/build-tools/$ANDROID_BUILD_TOOLS_VERSION"
fi

