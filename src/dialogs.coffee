#belongs to a class such as Game (mainMenu), a character instance (chat dialog), or scene (battles, events)
class DialogFactory
    constructor: ()->
        @dialogs = {}

    show: (dialog_name) ->
        if !@dialogs[dialog_name]?
            @register(dialog_name, mainMenuDialog())

        if !@dialogs[dialog_name].dialog("isOpen")
            @dialogs[dialog_name].dialog("open")
        else
            console.log("already open")

    register: (name, dialog) ->
        @dialogs[name] = dialog

    unregister: (name) -> 
        @dialogs.splice($.inArray(name, @dialogs), 1)

mainMenuDialog = () ->
    DialogConstruct = """
    <div id="MenuDialog">
        <div class="menu-content">
            <div class="absCenter">
                <button id="start-game" class="draggable-element editable">Start Game</button>
                <button id="options" class="draggable-element editable">Options</button>
                <button id="how-to" class="draggable-element editable">How-To</button>
            </div>
        </div>
    </div>
    """
    NewDialog = $(DialogConstruct)

    NewDialog.dialog({
        height: '240',
        width: '320',
        modal: true,
        closeOnEscape: false, 
        autoOpen: false,
        title: 'Miruku Menu'
        })

    $('.absCenter > :button').filter('.editable').button()
    $("#start-game").on('click', (event) -> 
        if $(this).hasClass('noclick')
            $(this).removeClass('noclick')
        else 
            NewDialog.dialog("close"))

    return NewDialog

editMenuDialog = () ->
    DialogConstruct = """
    <div id="EditDialog">
        <div class="menu-content">
            <div class="absCenter">
                <button id="one">One</button>
                <button id="two">Two</button>
                <button id="three">Three</button>
            </div>
        </div>
    </div>
    """

    NewDialog = $(DialogConstruct)

    NewDialog.dialog({
        height: '180',
        width: '180',
        modal: false,
        resizable: false,
        closeOnEscape: true, 
        autoOpen: false,
        title: 'Edit Menu'
        })
    $('.absCenter > :button').filter('.editable').button()

    return NewDialog
#loadMenuDialog = () ->
    #DialogConstruct