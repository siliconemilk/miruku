$.fn.classList = () -> return @className.split(/\s+/)

$ ->
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

    	for someClass in $(item).classList
    		console.log($(someClass).text)

    $("#clickme").text("DISABLE EDITING")

    $("#clickme").off("click")
    $("#clickme").on("click", (event) -> disableEdit())

    window.dialogFactory.show("mainMenu")

disableEdit = () ->
	for item in document.body.getElementsByTagName("*")
		if $(item).hasClass('draggable-element')
			$(item).draggable("option", "cancel", "input,textarea,button,select,option")

	editButton = $("#clickme")
	editButton.text("ENABLE EDITING")

	editButton.off("click")
	editButton.on('click', (event) -> enableEdit())
