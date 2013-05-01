$ ->
	init()

	#displayMainMenu(); 
	window.dialogFactory = new DialogFactory()
	#dialogFactory.register("mainMenu", mainMenuDialog)
	window.dialogFactory.register("mainMenu", mainMenuDialog())
	window.dialogFactory.show("mainMenu")
	$("#clickme").on('click', (event) -> enableEdit() )

enableEdit = () ->
    for item in document.body.getElementsByTagName("*")
    	if $(item).hasClass('draggable-element')
    		$(item).draggable({cancel: false, grid: [10,10], start: (event, ui) -> 
    			$(this).addClass('noclick') 
    			return
    			})

    window.dialogFactory.show("mainMenu")

init = () ->
	for item in document.body.getElementsByTagName("*")
    	if $(item).hasClass('draggable-element')
    		$(item).draggable({disabled: true, grid: [10,10]})