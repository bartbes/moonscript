
import build from require "moonscript.types"
import unpack from require "moonscript.util"

-- always declares as local
class LocalName
  new: (@name) => self[1] = "temp_name"
  get_name: => @name

-- creates a unique name when used
class NameProxy
  new: (@prefix) =>
    self[1] = "temp_name"

  get_name: (scope, dont_put=true) =>
    if not @name
      @name = scope\free_name @prefix, dont_put
    @name

  chain: (...) =>
    items = for i in *{...}
      if type(i) == "string"
        {"dot", i}
      else
        i

    build.chain {
      base: self
      unpack items
    }

  index: (key) =>
    build.chain {
      base: self, {"index", key}
    }

  __tostring: =>
    if @name
      ("name<%s>")\format @name
    else
      ("name<prefix(%s)>")\format @prefix


{ :NameProxy, :LocalName }
