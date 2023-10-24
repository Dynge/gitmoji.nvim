local gitmoji = require("gitmoji")
require("cmp").register_source(gitmoji.source_name(), gitmoji.get_source().new())
