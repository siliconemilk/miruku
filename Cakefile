fs = require 'fs'
util = require 'util'
{exec} = require 'child_process'

option '-s', '--source [DIR]', 'source dir'
option '-o', '--output [DIR]', 'output dir'
option '-d', '--deploy [DIR]', 'deployment dir'

#file inclusion order matters! Least->Most Dependant
sourceFiles = [
    'editor'
    'Character'
    'game'
    'dialogs'
    'main'
]

defines = [
    'DEBUG'
]

task 'build-monolith', 'Build a single application file from source.', (options) ->
    util.log "Building app.js..."
    appContents = new Array remaining = sourceFiles.length
    util.log "Appending #{sourceFiles.length} files to app.js"

    for file, index in sourceFiles then do (file, index) ->
        fs.readFile "src/#{file}.coffee", 'utf8', (err, fileContents) ->
            util.log err if err

            appContents[index] = fileContents
            util.log "[#{index + 1}] #{file}.coffee"
            process() if --remaining is 0

    process = ->
        fs.writeFile "lib/app.coffee", appContents.join('\n\n'), 'utf8', (err) ->
            util.log err if err

            simplePreprocessor("lib/app.coffee")

            exec "coffee --output lib --compile lib/app.coffee", (err, stdout, stderr) ->
                util.log err if err
                message = "Compiled app.js"
                util.log message
                
                #fs.unlink "lib/app.coffee", (err) -> util.log err if err

#FOR THE LOVE OF ALL THAT IS BACON, REWRITE THIS TO PROPERLY HANDLE DEFINES
#SUCH THAT #ifdef {definition in defines} UNTIL #endif
simplePreprocessor = (file) ->

    @lines = fs.readFileSync(file).toString().split('\n')
    
    for line, i in @lines
        if line.indexOf("#ifdef DEBUG") isnt -1
            util.log("detected DEBUG ifdef")
            lines[i] = ""
            i = i + 1
            line = lines[i]
            until line.indexOf("#endif") isnt -1
                util.log("...looking")
                lines[i] = ""
                i = i + 1
                line = lines[i]
            util.log("ending DEBUG ifdef block")
            lines[i] = ""
    util.log("writing to app.coffee")
    fs.writeFile "lib/app.coffee", @lines.join('\n'), 'utf8'