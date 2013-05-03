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

readyEdit = (event, ui) ->
    if window.editing
        enableEdit()

enableEdit = () ->
    #$('.editable').after('<button class="tool"><img src="./content/cog_alt_16x16.png"></img></button>')
    $('.editable').after('<button class="tool"/>')
    $('.tool').button({
        text: false,
        icons: { primary: "ui-icon-wrench"}
        })

    elements = document.body.getElementsByTagName("*")

    for item in elements
        if $(item).hasClass("editable")
  
            classes = $(item).classes()

            $(item).next().offset({left: $(item).outerWidth() + $(item).offset().left, top: $(item).offset().top})

            for itemClass in classes
                switch itemClass
                    when "draggable-element"
                        #if not initialized yet, we can safely initializle
                        if $.inArray("ui-draggable", classes) < 0
                            $(item).draggable({cancel: false, grid: [10,10], start: disableSubmitOnClick, drag: followOnDrag})


    editButton = $("#clickme")
    editButton.text("DISABLE EDITING")
    editButton.one("click", disableEdit)

    window.editing = true

    
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
    editButton.one('click', enableEdit)

    window.editiing = false