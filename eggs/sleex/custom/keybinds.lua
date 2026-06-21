hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"),
  { locked = true, desc = "Mute the microphone" }
)

hl.bind(
  "SUPER+Return",
  hl.dsp.exec_cmd("kitty"),
  { desc = "Launch terminal" }
)

hl.bind("SUPER+period", hl.dsp.global("quickshell:overviewEmojiToggle"), { desc = "Emoji >> clipboard" })
