#client code for generating a dialog. Will we need to put this in server as well? 

#if in edit mode, resizable is enabled. Disabled if not in edit mode. 
@hohoho = (type) -> 
	fragment = Meteor.render(
		() -> 
			if $("#" + type).length > 0
				return

			return "<div id=\"" + type + "\"><p> " + Session.get("dialogContent") + "</p></div>"
	)

	$('body').append(fragment)

	isAutoOpen = Session.get(type + "DialogAutoOpen") || true
	isModal = Session.get(type + "DialogIsModal") || false

	$("#" + type).dialog({
		height: 240, 
		width: 320, 
		modal: isModal, 
		resizable: true, 
		autoOpen: isAutoOpen,
		close: (event, ui) -> 
			$(this).dialog('destroy').remove()
	})

@createDialog = (type) ->
	elements.insert({type: type, class: type + "Element", content: "test"})
