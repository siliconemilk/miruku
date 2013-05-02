`(function ($) {
    $.fn.classes = function (callback) {
        var classes = [];
        $.each(this, function (i, v) {
            var splitClassName = v.className.split(/\s+/);
            for (var j in splitClassName) {
                var className = splitClassName[j];
                if ('' !== className) {
                    classes.push(className); // replace with 'classes.unshift(className);' to put classes in order of their appearance
                }
            }
        });
        classes = $.unique(classes);
        if ('function' === typeof callback) {
            for (var i in classes) {
                callback(classes[i]);
            }
        }
        return classes;
    };
})(jQuery);`

$ ->

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

    		myClasses = $(item).classes()
    		$.each(myClasses, (i, v) ->
    			console.log(v)
    			)

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
