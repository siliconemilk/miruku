fs = require 'fs'
util = require 'util'
{exec} = require 'child_process'

option '-s', '--source [DIR]', 'source dir'
option '-o', '--output [DIR]', 'output dir'
option '-d', '--deploy [DIR]', 'deployment dir'

sourceFiles = [
	'Character'
	'game'
	'dialogs'
	'main'
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

			exec "coffee --output lib --compile lib/app.coffee", (err, stdout, stderr) ->
				util.log err if err
				message = "Compiled app.js"
				util.log message
				fs.unlink "lib/app.coffee", (err) -> util.log err if err
