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

    
disableEdit = () ->
    $('.tool').remove()

    elements = document.body.getElementsByTagName("*")
    
    for item in elements
        if $(item).hasClass("editable")
            classes = $(item).classes()

            for itemClass in classes
                switch itemClass
                    when "draggable-element"
                        #check to make sure the draggable element has actually been initialized as a draggable
                        if $.inArray("ui-draggable", classes) > -1
                            $(item).draggable("option", "cancel", "input, textarea, button, select, option")

    editButton = $("#clickme")
    editButton.text("ENABLE EDITING")

    #editButton.off("click")
    editButton.one('click', enableEdit)