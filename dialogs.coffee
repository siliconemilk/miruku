@removeElements = () -> 
	elements.remove({})

@createDialog = (type, color) ->
	elements.insert({color: color, type: type, class: type + "Element", content: "Button " + elements.find().count()})
