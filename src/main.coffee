$ ->
	init()

	#displayMainMenu(); 
	dialogFactory = new DialogFactory()
	dialogFactory.register("mainMenu", displayMainMenu)
	dialogFactory.show("mainMenu")
	$("#clickme").on('click', (event) -> enableEdit() )

enableEdit = () ->
    for item in document.body.getElementsByTagName("*")
    	if $(item).hasClass('draggable-element')
    		$(item).draggable("option", "disabled", false)

    displayMainMenu()

init = () ->
	for item in document.body.getElementsByTagName("*")
    	if $(item).hasClass('draggable-element')
    		$(item).draggable({disabled: true})