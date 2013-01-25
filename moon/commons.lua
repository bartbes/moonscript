if common_class ~= false then
  common = {
    class = function(name, prototype, superclass)
      if superclass == nil then
        superclass = { }
      end
      local clazz
      do
        local _parent_0 = superclass
        local _base_0 = {
          __name = name
        }
        _base_0.__index = _base_0
        if _parent_0 then
          setmetatable(_base_0, _parent_0.__base)
        end
        local _class_0 = setmetatable({
          __init = prototype.init or superclass.init or superclass.new or function() end,
          __base = _base_0,
          __name = "clazz",
          __parent = _parent_0
        }, {
          __index = function(cls, name)
            local val = rawget(_base_0, name)
            if val == nil and _parent_0 then
              return _parent_0[name]
            else
              return val
            end
          end,
          __call = function(cls, ...)
            local _self_0 = setmetatable({}, _base_0)
            cls.__init(_self_0, ...)
            return _self_0
          end
        })
        _base_0.__class = _class_0
        if _parent_0 and _parent_0.__inherited then
          _parent_0.__inherited(_parent_0, _class_0)
        end
        clazz = _class_0
      end
      for i, v in pairs(prototype) do
        clazz.__base[i] = v
      end
      return clazz
    end,
    instance = function(clazz, ...)
      return clazz(...)
    end
  }
end
