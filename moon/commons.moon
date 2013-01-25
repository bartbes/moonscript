if common_class != false
	export common
	common =
		class: (name, prototype, superclass={}) ->
			clazz = class extends superclass
				__name: name
				new: prototype.init or superclass.init or superclass.new or () ->
			for i, v in pairs prototype
				clazz.__base[i] = v
			return clazz
		instance: (clazz, ...) ->
			clazz ...
