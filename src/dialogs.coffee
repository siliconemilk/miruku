#Types of dialogs we would possibly want to create: 
#   menu (main menu, options, loading, etc.). Would we want to simply replace the contents of a single dialog though for swapping menus?
#   submenu(non-modal dialog) - not entirely sure of a scenario this would come up but it could be helpful
#   chatter(chat between characters)

#type: string containing type of dialog we would like to attempt to create.
#   type will substitue name of html file such as domain:port/content/{type}.html
#target: DOM element which is to be considered the target of new dialog. For things such as the edit menu used by the editor  
createDialog = (type, target) ->
    $('body').append("<div id=\"" + type + "container\"></div>")
    DialogConstruct = $('#' + type + "container")
    $(DialogConstruct).load("http://" + domain + ":" + port + root + "content/" + type + ".html", () -> 
        someHeight = $('#' + type).data('height')
        someWidth =  $('#' + type).data('width')

        console.log(someWidth + " and " + someHeight)
        $(this).dialog({
        height: someHeight, 
        width: someWidth, 
        modal: $('#' + type).data('modal'),
        resizable: false, 
        autoOpen: false,
        title: $('#' + type).data('title')
        close: (event, ui) -> 
            $(this).dialog('destroy').remove()
            $(document).off('click', '#start-game')
        })

        $(this).find(':button').button()

        #delayed opening of the dialog so we get the proper width of the editable elements within the dialog's ajax content
        $(DialogConstruct).dialog("open")
        )

    NewDialog = $(DialogConstruct)

    $(document).on('click', '#start-game', (event) -> 
        if $(this).hasClass('noclick')
            $(this).removeClass('noclick')
        else 
            NewDialog.dialog("close"))

    return NewDialog