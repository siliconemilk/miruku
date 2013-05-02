#main game state machine (paused, running, title screen, etc.)
class Game
    constructor: (@state) ->

    #import file containing save data
    importFile: (filename) -> 

    #export save data to a file
    exportFile: (filename) ->


#game session contains character info and current world progress.
#this is the data saved by the game.
class GameSession
    constructor: () ->

    #save current game
    save: () -> 

    #load game from save slot number
    load: (slot) ->

    @Player: new Character "Miruku"
