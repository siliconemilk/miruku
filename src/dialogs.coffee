class DialogFactory
	constructor: ()->
		@dialogs = {}

	show: (dialog_name) ->
		if !@dialogs[dialog_name]().dialog("isOpen")
			@dialogs[dialog_name]().dialog("open")
		else
			console.log("already open")

	register: (name, dialog) ->
		@dialogs[name] = dialog

mainMenuDialog = () ->
	DialogConstruct = """
	<div id="MenuDialog">
		<div class="menu-content">
			<button id="start-game">Start Game</button><br/>
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

	return NewDialog

loadMenuDialog = () ->
	DialogConstruct