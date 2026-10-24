//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_FFMPEG_DECODING_HW_DEVICE_TYPES=vaapi
//@ pragma Env LIBVA_DRIVER_NAME=iHD

import Quickshell
import QtQuick

import qs.ui.wallpaper
import qs.ui.island

ShellRoot {
    Wallpaper {}
    Island {}
}
