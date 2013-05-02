#helper class listing function for DOM elements
#pulled from http://stackoverflow.com/a/11232541
#Thank you, Will!
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
    $("#clickme").one("click", enableEdit )

#prevents triggering of submit action on button immediately after dragging
#buttons will automatically remove noclick class after a successful drag
disableSubmitOnClick = (event, ui) ->
    $(this).addClass('noclick')
    return

followOnDrag = (event, ui) ->
    width = $(this).outerWidth()
    console.log(width)
    offset = {}
    offset.left = (width + ui.offset.left)
    offset.top = ui.offset.top

    $(this).next().offset(offset)

enableEdit = () ->
    $('.editable').after('<button class="tool"><img src="./content/cog_alt_16x16.png"></img></button>')

    elements = document.body.getElementsByTagName("*")

    for item in elements
        if $(item).hasClass("editable")
  
            classes = $(item).classes()

            $(item).next().offset({left: $(item).outerWidth() + $(item).offset().left, top: $(item).offset().top})
            for itemClass in classes
                switch itemClass
                    when "draggable-element"
                        $(item).draggable({cancel: false, grid: [10,10], start: disableSubmitOnClick, drag: followOnDrag})


    $("#clickme").text("DISABLE EDITING")

    #$("#clickme").off("click")
    $("#clickme").one("click", disableEdit)

    window.dialogFactory.show("mainMenu")

disableEdit = () ->
    $('.tool').remove()

    elements = document.body.getElementsByTagName("*")
    
    for item in elements
        if $(item).hasClass("editable")
            classes = $(item).classes()

            for itemClass in classes
                switch itemClass
                    when "draggable-element"
                        $(item).draggable("option", "cancel", "input, textarea, button, select, option")

    editButton = $("#clickme")
    editButton.text("ENABLE EDITING")

    #editButton.off("click")
    editButton.one('click', enableEdit)
