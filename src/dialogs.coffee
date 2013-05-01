#belongs to a class such as Game (mainMenu), a character instance (chat dialog), or scene (battles, events)
class DialogFactory
	constructor: ()->
		@dialogs = {}

	show: (dialog_name) ->
		if !@dialogs[dialog_name].dialog("isOpen")
			@dialogs[dialog_name].dialog("open")
		else
			console.log("already open")

	register: (name, dialog) ->
		@dialogs[name] = dialog

mainMenuDialog = () ->
	DialogConstruct = """
	<div id="MenuDialog">
		<div class="menu-content">
			<button id="start-game" class="draggable-element">Start Game</button><br/>
			<button id="options">Options</button><br/>
			<button id="how-to">How-To</button>
		</div>
	</div>
	"""

	NewDialog = $(DialogConstruct)

	NewDialog.dialog({
    	height: '240',
    	width: '320',
    	modal: true,
    	resizable: false,
    	closeOnEscape: false, 
    	autoOpen: false,
    	title: 'Miruku Menu'
    	})

	$("#start-game").on('click', (event) -> 
		if $(this).hasClass('noclick')
			$(this).removeClass('noclick')
		else 
			NewDialog.dialog("close"))

	return NewDialog

loadMenuDialog = () ->
	DialogConstruct