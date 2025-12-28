local ls = require "luasnip"
local snip = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  snip({ trig = "if", name = "execute if" }, {
    t "execute if ",
    i(1, "condition"),
    t " run ",
  }),
  snip({ trig = "unless", name = "execute unless" }, {
    t "execute unless ",
    i(1, "condition"),
    t " run ",
  }),
  snip({ trig = "scb-obj-add", name = "scoreboard objectives add", desc = "Adds a new scoreboard objective" }, {
    t "scoreboard objectives add ",
    i(1),
    t " dummy",
  }),
  snip({ trig = "scb-incr", name = "scoreboard players add", desc = "Increments a player's score" }, {
    t "scoreboard players add ",
    i(1, "target"),
    t " ",
    i(2, "objective"),
    t " ",
    i(3, "amount"),
  }),
  snip({ trig = "scb-decr", name = "scoreboard players remove", desc = "Decrements a player's score" }, {
    t "scoreboard players remove ",
    i(1, "target"),
    t " ",
    i(2, "objective"),
    t " ",
    i(3, "amount"),
  }),
}
