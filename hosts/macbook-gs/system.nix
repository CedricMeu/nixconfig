{ username, ... }:
{
  environment.variables = {
    ANDROID_SDK_ROOT = "/Users/${username}/Library/Android/sdk";
    ANDROID_HOME = "/Users/${username}/Library/Android/sdk";
    ANDROID_AVD_HOME = "/Users/${username}/.android/avd";

    ANDROID_BUILD_TOOLS = "/Users/${username}/Library/Android/sdk/build-tools/33.0.0";
    ANDROID_PLATFORM_TOOLS = "/Users/${username}/Library/Android/sdk/platform-tools";

    MATCH_KEY_JSON = "/Users/${username}/.config/guardsquare/fastlane.json";
  };

  environment.systemPath = [ ];
}
