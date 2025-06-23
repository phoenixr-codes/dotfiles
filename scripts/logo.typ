#import "@preview/catppuccin:1.0.0": flavors
#let flavor = flavors.mocha
#let colors = flavor.colors
#let gradient = gradient.linear(
  colors.rosewater.rgb,
  colors.flamingo.rgb,
  colors.pink.rgb,
  colors.mauve.rgb,
  colors.red.rgb,
  colors.maroon.rgb,
  colors.peach.rgb,
  colors.yellow.rgb,
  colors.green.rgb,
  colors.teal.rgb,
  colors.sky.rgb,
  colors.sapphire.rgb,
  colors.blue.rgb,
  colors.lavender.rgb
)
#set page(fill: rgb(0, 0, 0, 0), width: 3.5em, height: 2em)
#set align(center + horizon)
#set text(fill: gradient, font: "Courgette", baseline: 3pt)

dotfiles
